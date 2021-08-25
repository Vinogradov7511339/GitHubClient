//
//  RepositoriesViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

enum RepositoriesViewModelType {
    case all
    case starred
}

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
    private let user: User
    private let userUseCase: UserProfileUseCase
    private let type: RepositoriesViewModelType
    private let actions: RepositoriesActions
    private var lastPage: Int?
    private var currentPage: Int = 1

    init(user: User, userUseCase: UserProfileUseCase, type: RepositoriesViewModelType, actions: RepositoriesActions) {
        self.user = user
        self.userUseCase = userUseCase
        self.type = type
        self.actions = actions
        self.title = Observable("")

        switch type {
        case .all:
            title.value = NSLocalizedString("Repositories", comment: "")
        case .starred:
            title.value = NSLocalizedString("Starred", comment: "")
        }
    }
}

// MARK: - Input
extension RepositoriesViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func didSelectItem(at indexPath: IndexPath) {
        actions.showRepository(repositories.value[indexPath.row])
    }
}

// MARK: - Private
private extension RepositoriesViewModelImpl {
    func fetch() {
        let model = UsersRequestModel(user: user, page: currentPage)
        switch type {
        case .all:
            userUseCase.fetchRepositories(request: model, completion: completion(_:))
        case .starred:
            userUseCase.fetchStarred(request: model, completion: completion(_:))
        }
    }

    func completion(_ result: Result<ListResponseModel<Repository>, Error>) {
        switch result {
        case .success(let model):
            self.lastPage = model.lastPage
            self.repositories.value.append(contentsOf: model.items)
        case .failure(let error):
            print(error)
        }
    }
}
