//
//  UsersListFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 12.08.2021.
//

import UIKit

protocol UserFactory {
    func profileViewController(user: User, _ actions: UserProfileActions) -> UIViewController
    func followersViewController(user: User, _ actions: UsersListActions) -> UIViewController
    func followingViewController(user: User, _ actions: UsersListActions) -> UIViewController
    func repositoriesViewController(user: User, _ actions: RepositoriesActions) -> UIViewController
    func starredViewController(user: User, _ actions: RepositoriesActions) -> UIViewController
    func eventsViewController(user: User, _ actions: EventsActions) -> UIViewController
}

final class UsersListFactoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - UsersListFactory
extension UsersListFactoryImpl: UserFactory {

    func profileViewController(user: User, _ actions: UserProfileActions) -> UIViewController {
        UserProfileViewController.create(with: userProfileViewModel(user: user, actions: actions))
    }

    func followersViewController(user: User, _ actions: UsersListActions) -> UIViewController {
        UsersListViewController.create(with: followersViewModel(for: user, actions: actions))
    }

    func followingViewController(user: User, _ actions: UsersListActions) -> UIViewController {
        UsersListViewController.create(with: followingViewModel(for: user, actions: actions))
    }

    func repositoriesViewController(user: User, _ actions: RepositoriesActions) -> UIViewController {
        RepositoriesViewController.create(with: repositoriesViewModel(for: user, actions: actions))
    }

    func starredViewController(user: User, _ actions: RepositoriesActions) -> UIViewController {
        RepositoriesViewController.create(with: repositoriesViewModel(for: user, actions: actions))
    }

    func eventsViewController(user: User, _ actions: EventsActions) -> UIViewController {
        UserEventsViewController()
    }
}

private extension UsersListFactoryImpl {
    func userProfileViewModel(user: User, actions: UserProfileActions) -> UserProfileViewModel {
        return UserProfileViewModelImpl(user: user,
                                        userProfileUseCase: userUseCase,
                                        actions: actions)
    }

    func followersViewModel(for user: User, actions: UsersListActions) -> UsersListViewModel {
        UsersListViewModelImpl.init(user: user, userUseCase: userUseCase, type: .followers, actions: actions)
    }

    func followingViewModel(for user: User, actions: UsersListActions) -> UsersListViewModel {
        UsersListViewModelImpl.init(user: user, userUseCase: userUseCase, type: .following, actions: actions)
    }

    func repositoriesViewModel(for user: User, actions: RepositoriesActions) -> RepositoriesViewModel {
        RepositoriesViewModelImpl(user: user, userUseCase: userUseCase, type: .all, actions: actions)
    }

    func starredViewModel(for user: User, actions: RepositoriesActions) -> RepositoriesViewModel {
        RepositoriesViewModelImpl(user: user, userUseCase: userUseCase, type: .starred, actions: actions)
    }

    var userUseCase: UserProfileUseCase {
        UserProfileUseCaseImpl(userRepository: userRepository)
    }

    var userRepository: UserRepository {
        UserProfileRepositoryImpl(dataTransferService: dataTransferService)
    }
}
