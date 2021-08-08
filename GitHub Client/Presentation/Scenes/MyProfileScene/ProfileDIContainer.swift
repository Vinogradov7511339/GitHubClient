//
//  ProfileDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import UIKit

final class ProfileDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService

        var openUserProfile: (User) -> Void
        var openRepository: (Repository) -> Void
        var sendMail: (String) -> Void
        var openLink: (URL) -> Void
        var share: (URL) -> Void
    }

    let dependencies: Dependencies

    // MARK: - Persistent Storage
    private let profileStorage: ProfileLocalStorage
    private let profileFactory: MyProfileFactory
    private let itemsListFactory: ItemsListFactory

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.profileStorage = ProfileLocalStorageImpl()
        self.profileFactory = MyProfileFactoryImpl(
            dataTransferService: dependencies.apiDataTransferService,
            storage: profileStorage)
        self.itemsListFactory = ItemsListFactoryImpl(dataTransferService: dependencies.apiDataTransferService)
    }

    func createProfileViewController(_ actions: ProfileActions) -> ProfileViewController {
        profileFactory.makeMyProfileViewController(actions)
    }

    func createFollowersViewController(actions: ItemsListActions<User>) -> ItemsListViewController<User> {
        itemsListFactory.makeMyFollowersViewController(actions: actions)
    }

    func createFollowingViewController(actions: ItemsListActions<User>) -> ItemsListViewController<User> {
        itemsListFactory.makeMyFollowingViewController(actions: actions)
    }

    func createRepositoriesViewController(
        actions: ItemsListActions<Repository>) -> ItemsListViewController<Repository> {
        itemsListFactory.createMyRepositoriesViewController(actions: actions)
    }

    func createStarredViewController(actions: ItemsListActions<Repository>) -> ItemsListViewController<Repository> {
        itemsListFactory.createMyStarredViewController(actions: actions)
    }
}
