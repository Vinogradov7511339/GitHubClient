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
    private let itemsListFactory: ItemsListFactory
    private let usersListFactory: UsersListFactory

    init(parentContainer: MainSceneDIContainer, actions: Actions) {
        self.actions = actions
        self.profileStorage = ProfileLocalStorageImpl()
        self.profileFactory = MyProfileFactoryImpl(dataTransferService: parentContainer.apiDataTransferService,
            storage: profileStorage)
        self.itemsListFactory = ItemsListFactoryImpl(dataTransferService: parentContainer.apiDataTransferService)
        self.usersListFactory = UsersListFactoryImpl(dataTransferService: parentContainer.apiDataTransferService)
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
        actions: ItemsListActions<Repository>) -> ItemsListViewController<Repository> {
        itemsListFactory.createMyRepositoriesViewController(actions: actions)
    }

    func createStarredViewController(actions: ItemsListActions<Repository>) -> ItemsListViewController<Repository> {
        itemsListFactory.createMyStarredViewController(actions: actions)
    }
}
