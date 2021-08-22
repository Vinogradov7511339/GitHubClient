//
//  UsersListViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 12.08.2021.
//

import UIKit

enum UsersViewModelType {
    case followers
    case following
}

struct UsersListActions {
    let showUser: (User) -> Void
}

protocol UsersListViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
}

protocol UsersListViewModelOutput {
    var title: Observable<String> { get }
    var users: Observable<[User]> { get }
}

typealias UsersListViewModel = UsersListViewModelInput & UsersListViewModelOutput

final class UsersListViewModelImpl: UsersListViewModel {

    // MARK: - Output

    var title: Observable<String> = Observable("")
    var users: Observable<[User]> = Observable([])

    // MARK: - Private variables

    private let user: User
    private let userUseCase: UserProfileUseCase
    private let type: UsersViewModelType
    private let actions: UsersListActions
    private var lastPage: Int?
    private var currentPage: Int

    init(user: User, userUseCase: UserProfileUseCase, type: UsersViewModelType, actions: UsersListActions) {
        self.user = user
        self.userUseCase = userUseCase
        self.type = type
        self.actions = actions
        self.currentPage = 1
        switch type {
        case .followers:
            title.value = NSLocalizedString("Followers", comment: "")
        case .following:
            title.value = NSLocalizedString("Following", comment: "")
        }
    }
}

// MARK: - Input
extension UsersListViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func didSelectItem(at indexPath: IndexPath) {
        actions.showUser(users.value[indexPath.row])
    }
}

// MARK: - Private
private extension UsersListViewModelImpl {
    func fetch() {
        let model = UsersRequestModel(user: user, page: currentPage)
        switch type {
        case .followers:
            userUseCase.fetchFollowers(request: model, completion: handle(_:))
        case .following:
            userUseCase.fetchFollowing(request: model, completion: handle(_:))
        }
    }

    func handle(_ result: Result<ListResponseModel<User>, Error>) {

    }
}
