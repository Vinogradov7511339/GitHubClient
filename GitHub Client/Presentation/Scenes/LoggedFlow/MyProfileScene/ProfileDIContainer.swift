//
//  ProfileDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import UIKit

final class ProfileDIContainer {

    // MARK: - Dependencies

    struct Dependencies {
        let dataTransferService: DataTransferService

        var openUserProfile: (User, UINavigationController) -> Void
        var openRepository: (Repository, UINavigationController) -> Void
        var openSettings: (UINavigationController) -> Void
        var sendMail: (String) -> Void
        var openLink: (URL) -> Void
        var share: (URL) -> Void
    }

    // MARK: - Private variables

    private let dependencies: Dependencies
    private let profileStorage: ProfileLocalStorage
    private let profileFactory: MyProfileFactory

    init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
        self.profileStorage = ProfileLocalStorageImpl()
        profileFactory = MyProfileFactoryImpl(dataTransferService: dependencies.dataTransferService,
            storage: profileStorage)
    }
}

// MARK: - ProfileFlowCoordinatorDependencies
extension ProfileDIContainer: ProfileFlowCoordinatorDependencies {
    func profileViewController(_ actions: ProfileActions) -> UIViewController {
        profileFactory.profileViewController(actions)
    }

    func followersViewController(_ actions: MyUsersViewModelActions) -> UIViewController {
        profileFactory.followersViewController(actions)
    }

    func followingViewController(_ actions: MyUsersViewModelActions) -> UIViewController {
        profileFactory.followingViewController(actions)
    }

    func subscriptionsViewController() -> UIViewController {
        profileFactory.subscriptionsViewControler()
    }

    func showRepositories(_ actions: MyRepositoriesActions) -> UIViewController {
        profileFactory.repositoriesViewController(actions)
    }

    func showStarred(_ actions: MyRepositoriesActions) -> UIViewController {
        profileFactory.starredViewController(actions)
    }

    func openSettings(in nav: UINavigationController) {
        dependencies.openSettings(nav)
    }

    func openRepository(_ repository: Repository, in nav: UINavigationController) {
        dependencies.openRepository(repository, nav)
    }

    func openProfile(_ user: User, in nav: UINavigationController) {
        dependencies.openUserProfile(user, nav)
    }

    func share(_ url: URL) {
        dependencies.share(url)
    }

    func open(_ link: URL) {
        dependencies.openLink(link)
    }

    func send(_ email: String) {
        dependencies.sendMail(email)
    }
}
