//
//  UsersListFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 12.08.2021.
//

import Foundation

protocol UsersListFactory {
    func makeMyFollowersViewController(actions: UsersListActions) -> UsersListViewController
    func makeMyFollowingViewController(actions: UsersListActions) -> UsersListViewController

    func createFollowersViewController(for user: User, actions: UsersListActions) -> UsersListViewController
    func createFollowingViewController(for user: User, actions: UsersListActions) -> UsersListViewController
}

final class UsersListFactoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - UsersListFactory
extension UsersListFactoryImpl: UsersListFactory {
    func makeMyFollowersViewController(actions: UsersListActions) -> UsersListViewController {
        .create(with: createMyFollowersViewModel(actions: actions))
    }

    func makeMyFollowingViewController(actions: UsersListActions) -> UsersListViewController {
        .create(with: createMyFollowingViewModel(actions: actions))
    }

    func createFollowersViewController(for user: User, actions: UsersListActions) -> UsersListViewController {
        .create(with: createFollowersViewModel(for: user, actions: actions))
    }

    func createFollowingViewController(for user: User, actions: UsersListActions) -> UsersListViewController {
        .create(with: createFollowingViewModel(for: user, actions: actions))
    }
}

private extension UsersListFactoryImpl {
    func createMyFollowersViewModel(actions: UsersListActions) -> UsersListViewModel {
        UsersListViewModelImpl.init(useCase: createUsersListUseCase(), type: .myFollowers, actions: actions)
    }

    func createMyFollowingViewModel(actions: UsersListActions) -> UsersListViewModel {
        UsersListViewModelImpl.init(useCase: createUsersListUseCase(), type: .myFollowing, actions: actions)
    }

    func createFollowersViewModel(for user: User, actions: UsersListActions) -> UsersListViewModel {
        UsersListViewModelImpl.init(useCase: createUsersListUseCase(), type: .userFollowers(user), actions: actions)
    }

    func createFollowingViewModel(for user: User, actions: UsersListActions) -> UsersListViewModel {
        UsersListViewModelImpl.init(useCase: createUsersListUseCase(), type: .userFollowings(user), actions: actions)
    }

    func createUsersListUseCase() -> UsersListUseCase {
        return UsersListUseCaseImpl(repository: createUsersListRepository())
    }

    func createUsersListRepository() -> UsersListRepository {
        return UsersListRepositoryImpl(dataTransferService: dataTransferService)
    }
}
