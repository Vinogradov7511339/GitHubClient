//
//  RepositoryUsersViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.08.2021.
//

import UIKit

struct UsersActions {
    let showUser: (URL) -> Void
}

enum RepositoryUsersType {
    case following(URL)
    case followers(URL)

    case stargazers(URL)
    case subscribers(URL)
    case contributors(URL)

    var url: URL {
        switch self {
        case .followers(let url): return url
        case .following(let url): return url

        case .stargazers(let url): return url
        case .subscribers(let url): return url
        case .contributors(let url): return url
        }
    }

    var title: String {
        switch self {
        case .followers(_):
            return NSLocalizedString("Followers", comment: "")
        case .following(_):
            return NSLocalizedString("Following", comment: "")
        case .stargazers(_):
            return NSLocalizedString("Stargazers", comment: "")
        case .subscribers(_):
            return NSLocalizedString("Subscribres", comment: "")
        case .contributors(_):
            return NSLocalizedString("Contributors", comment: "")
        }
    }
}

protocol UsersViewModelInput {
    func viewDidLoad()
    func refresh()
    func didSelectItem(at indexPath: IndexPath)
}

protocol UsersViewModelOutput {
    var title: Observable<String> { get }
    var state: Observable<ItemsSceneState<User>> { get }
}

typealias UsersViewModel = UsersViewModelInput & UsersViewModelOutput

final class UsersViewModelImpl: UsersViewModel {

    // MARK: - Output

    var title: Observable<String>
    var state: Observable<ItemsSceneState<User>> = Observable(.loading)

    // MARK: - Private variables

    private let type: RepositoryUsersType
    private let useCase: ListUseCase
    private let actions: UsersActions
    private var currentPage = 1
    private var lastPage: Int?

    // MARK: - Lifecycle

    init(_ type: RepositoryUsersType, useCase: ListUseCase, actions: UsersActions) {
        self.type = type
        self.useCase = useCase
        self.actions = actions
        self.title = Observable(type.title)
    }
}

// MARK: - Input
extension UsersViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func refresh() {
        fetch()
    }

    func didSelectItem(at indexPath: IndexPath) {
        guard case .loaded(let users) = state.value else { return }
        actions.showUser(users[indexPath.row].url)
    }
}

// MARK: - Private
private extension UsersViewModelImpl {
    func fetch() {
        state.value = .loading
        let requestModel = ListRequestModel(path: type.url, page: currentPage)
        useCase.fetchUsers(requestModel) { result in
            switch result {
            case .success(let model):
                self.lastPage = model.lastPage
                self.state.value = .loaded(items: model.items)
            case .failure(let error):
                self.state.value = .error(error: error)
            }
        }
    }
}
