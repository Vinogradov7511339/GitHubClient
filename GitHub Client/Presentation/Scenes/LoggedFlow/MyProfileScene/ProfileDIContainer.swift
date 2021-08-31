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

        var openUserProfile: (URL, UINavigationController) -> Void
        var openRepository: (URL, UINavigationController) -> Void
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
    func profileViewController(actions: ProfileActions) -> UIViewController {
        profileFactory.profileViewController(actions: actions)
    }

    func followersViewController(_ url: URL, actions: UsersActions) -> UIViewController {
        profileFactory.followersViewController(url, actions: actions)
    }

    func followingViewController(_ url: URL, actions: UsersActions) -> UIViewController {
        profileFactory.followingViewController(url, actions: actions)
    }

    func subscriptionsViewController() -> UIViewController {
        profileFactory.subscriptionsViewControler()
    }

    func showRepositories(_ url: URL, actions: RepositoriesActions) -> UIViewController {
        profileFactory.repositoriesViewController(url, actions: actions)
    }

    func showStarred(_ url: URL, actions: RepositoriesActions) -> UIViewController {
        profileFactory.starredViewController(url, actions: actions)
    }

    func openSettings(in nav: UINavigationController) {
        dependencies.openSettings(nav)
    }

    func openRepository(_ repository: URL, in nav: UINavigationController) {
        dependencies.openRepository(repository, nav)
    }

    func openProfile(_ user: URL, in nav: UINavigationController) {
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
