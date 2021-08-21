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

    init(parentContainer: MainSceneDIContainer, actions: Actions) {
        self.actions = actions
        self.profileStorage = ProfileLocalStorageImpl()
        profileFactory = MyProfileFactoryImpl(dataTransferService: parentContainer.apiDataTransferService,
            storage: profileStorage)
    }

    func createProfileViewController(_ actions: ProfileActions) -> UIViewController {
        profileFactory.profileViewController(actions)
    }

    func createFollowersViewController(actions: MyUsersViewModelActions) -> UIViewController {
        profileFactory.followersViewController(actions)
    }

    func createFollowingViewController(actions: MyUsersViewModelActions) -> UIViewController {
        profileFactory.followingViewController(actions)
    }

    func createRepositoriesViewController(actions: MyRepositoriesActions) -> UIViewController {
        profileFactory.repositoriesViewController(actions)
    }

    func createStarredViewController(actions: MyRepositoriesActions) -> UIViewController {
        profileFactory.starredViewController(actions)
    }

    func createSubscriptionsViewController() -> UIViewController {
        profileFactory.subscriptionsViewControler()
    }
}
