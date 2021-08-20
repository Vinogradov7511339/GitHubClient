//
//  RepositoriesViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

struct RepositoriesActions {
    let showRepository: (Repository) -> Void
}

protocol RepositoriesViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
}

protocol RepositoriesViewModelOutput {
    var repositories: Observable<[Repository]> { get }
    var title: Observable<String> { get }
}

typealias RepositoriesViewModel = RepositoriesViewModelInput & RepositoriesViewModelOutput

final class RepositoriesViewModelImpl: RepositoriesViewModel {

    // MARK: - Output
    var repositories: Observable<[Repository]> = Observable([])
    var title: Observable<String>

    // MARK: - Private
    private let useCase: RepositoriesUseCase
    private let type: RepositoriesType
    private let actions: RepositoriesActions
    private var lastPage: Int?

    init(useCase: RepositoriesUseCase, type: RepositoriesType, actions: RepositoriesActions) {
        self.useCase = useCase
        self.type = type
        self.actions = actions
        self.title = Observable("")

        switch type {
        case .myRepositories, .userRepositories(_):
            title.value = NSLocalizedString("Repositories", comment: "")
        case .myStarred, .userStarred(_):
            title.value = NSLocalizedString("Starred", comment: "")
        case .forks(_):
            title.value = NSLocalizedString("Forks", comment: "")
        }
    }
}

// MARK: - Input
extension RepositoriesViewModelImpl {
    func viewDidLoad() {
        let page = 1
        let request = RepositoriesRequestModel(page: page, listType: type)
        useCase.fetch(request: request) { result in
            switch result {
            case .success(let model):
                self.lastPage = model.lastPage
                self.repositories.value.append(contentsOf: model.items)
            case .failure(let error):
                print(error)
            }
        }
    }

    func didSelectItem(at indexPath: IndexPath) {
        actions.showRepository(repositories.value[indexPath.row])
    }
}
