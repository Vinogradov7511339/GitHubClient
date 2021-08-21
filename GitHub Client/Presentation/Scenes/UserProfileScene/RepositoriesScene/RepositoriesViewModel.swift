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
    private let userUseCase: UserProfileUseCase
    private let type: RepositoriesType
    private let actions: RepositoriesActions
    private var lastPage: Int?
    private var currentPage: Int = 1

    init(userUseCase: UserProfileUseCase, type: RepositoriesType, actions: RepositoriesActions) {
        self.userUseCase = userUseCase
        self.type = type
        self.actions = actions
        self.title = Observable("")

        switch type {
        case .userRepositories(_):
            title.value = NSLocalizedString("Repositories", comment: "")
        case .userStarred(_):
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
        switch type {
        case .userRepositories(let user):
            let model = UsersRequestModel(user: user, page: currentPage)
            userUseCase.fetchRepositories(request: model, completion: completion(_:))
        case .userStarred(let user):
            let model = UsersRequestModel(user: user, page: currentPage)
            userUseCase.fetchStarred(request: model, completion: completion(_:))
        }
    }

    func completion(_ result: Result<RepListResponseModel, Error>) {
        switch result {
        case .success(let model):
            self.lastPage = model.lastPage
            self.repositories.value.append(contentsOf: model.repositories)
        case .failure(let error):
            print(error)
        }
    }
}
