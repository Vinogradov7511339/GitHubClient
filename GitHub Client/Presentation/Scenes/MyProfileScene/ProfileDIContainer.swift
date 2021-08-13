//
//  ProfileDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import UIKit

final class ProfileDIContainer {
    
    struct Actions {
        var openUserProfile: (User) -> Void
        var openRepository: (Repository) -> Void
        var sendMail: (String) -> Void
        var openLink: (URL) -> Void
        var share: (URL) -> Void
    }

    let actions: Actions

    // MARK: - Persistent Storage
    private let profileStorage: ProfileLocalStorage
    private let profileFactory: MyProfileFactory
    private let usersListFactory: UsersListFactory
    private let repositoriesFactory: RepositoriesFactory

    init(parentContainer: MainSceneDIContainer, actions: Actions) {
        self.actions = actions
        self.profileStorage = ProfileLocalStorageImpl()
        self.profileFactory = MyProfileFactoryImpl(dataTransferService: parentContainer.apiDataTransferService,
            storage: profileStorage)
        self.usersListFactory = UsersListFactoryImpl(dataTransferService: parentContainer.apiDataTransferService)
        self.repositoriesFactory = RepositoriesFactoryImpl(dataTransferService: parentContainer.apiDataTransferService)
    }

    func createProfileViewController(_ actions: ProfileActions) -> ProfileViewController {
        profileFactory.makeMyProfileViewController(actions)
    }

    func createFollowersViewController(actions: UsersListActions) -> UsersListViewController {
        usersListFactory.makeMyFollowersViewController(actions: actions)
    }

    func createFollowingViewController(actions: UsersListActions) -> UsersListViewController {
        usersListFactory.makeMyFollowingViewController(actions: actions)
    }

    func createRepositoriesViewController(
        actions: RepositoriesActions) -> RepositoriesViewController {
        repositoriesFactory.makeMyRepositoriesViewController(actions: actions)
    }

    func createStarredViewController(actions: RepositoriesActions) -> RepositoriesViewController {
        repositoriesFactory.makeMyStarredViewController(actions: actions)
    }
}
