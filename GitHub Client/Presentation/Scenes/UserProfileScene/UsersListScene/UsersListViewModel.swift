//
//  UsersListViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 12.08.2021.
//

import UIKit

struct UsersListActions {
    let showUser: (User) -> Void
}

protocol UsersListViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
}

protocol UsersListViewModelOutput {
    var users: Observable<[User]> { get }
}

typealias UsersListViewModel = UsersListViewModelInput & UsersListViewModelOutput

final class UsersListViewModelImpl: UsersListViewModel {

    // MARK: - Output
    var users: Observable<[User]> = Observable([])

    // MARK: - Private
    private let userUseCase: UserProfileUseCase
    private let type: UsersListType
    private let actions: UsersListActions
    private var lastPage: Int?
    private var currentPage: Int

    init(userUseCase: UserProfileUseCase, type: UsersListType, actions: UsersListActions) {
        self.userUseCase = userUseCase
        self.type = type
        self.actions = actions
        self.currentPage = 1
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
        switch type {
        case .userFollowers(let user):
            let model = UsersRequestModel(user: user, page: currentPage)
            userUseCase.fetchFollowers(request: model, completion: handle(_:))
        case .userFollowings(let user):
            let model = UsersRequestModel(user: user, page: currentPage)
            userUseCase.fetchFollowing(request: model, completion: handle(_:))
        }
    }

    func handle(_ result: Result<UsersResponseModel, Error>) {

    }
}
