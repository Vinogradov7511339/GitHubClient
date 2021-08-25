//
//  StarredSceneDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class UserProfileDIContainer {

    // MARK: - Dependencies

    struct Dependencies {
        let dataTransferService: DataTransferService
        let user: User

        var startRepFlow: (Repository, UINavigationController) -> Void
        var openLink: (URL) -> Void
        var share: (URL) -> Void
        var sendEmail: (String) -> Void

        let showRecentEvents: (User, UINavigationController) -> Void
        let showStarred: (User, UINavigationController) -> Void
        let showGists: (User, UINavigationController) -> Void
        let showSubscriptions: (User, UINavigationController) -> Void
        let showEvents: (User, UINavigationController) -> Void

        let showRepositories: (User, UINavigationController) -> Void
        let showFollowers: (User, UINavigationController) -> Void
        let showFollowing: (User, UINavigationController) -> Void
    }

    // MARK: - Private variables

    private let dependencies: Dependencies
    private let userFactory: UserFactory

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        userFactory = UsersListFactoryImpl(dataTransferService: dependencies.dataTransferService)
    }
}

// MARK: - StarredFlowCoordinatorDependencies
extension UserProfileDIContainer: UserFlowCoordinatorDependencies {
    func showFollowers(_ user: User, in nav: UINavigationController) {
        dependencies.showFollowers(user, nav)
    }

    func showFollowing(_ user: User, in nav: UINavigationController) {
        dependencies.showFollowing(user, nav)
    }

    func showRepositories(_ user: User, in nav: UINavigationController) {
        dependencies.showRepositories(user, nav)
    }

    func showStarred(_ user: User, in nav: UINavigationController) {
        dependencies.showStarred(user, nav)
    }

    func showRecentEvents(_ user: User, in nav: UINavigationController) {
        dependencies.showRecentEvents(user, nav)
    }

    func showGists(_ user: User, in nav: UINavigationController) {
        dependencies.showGists(user, nav)
    }

    func showSubscriptions(_ user: User, in nav: UINavigationController) {
        dependencies.showSubscriptions(user, nav)
    }

    func showEvents(_ user: User, in nav: UINavigationController) {
        dependencies.showEvents(user, nav)
    }

    func sendMail(email: String) {
        dependencies.sendEmail(email)
    }

    func openLink(url: URL) {
        dependencies.openLink(url)
    }

    func share(url: URL) {
        dependencies.share(url)
    }

    // MARK: - Factory

    func profileViewController(actions: UserProfileActions) -> UIViewController {
        userFactory.profileViewController(user: dependencies.user, actions)
    }

    func repositoriesViewController(actions: RepositoriesActions) -> UIViewController {
        userFactory.repositoriesViewController(user: dependencies.user, actions)
    }

    func starredViewController(actions: RepositoriesActions) -> UIViewController {
        userFactory.starredViewController(user: dependencies.user, actions)
    }

    func followersViewController(actions: UsersListActions) -> UIViewController {
        userFactory.followersViewController(user: dependencies.user, actions)
    }

    func followingViewController(actions: UsersListActions) -> UIViewController {
        userFactory.followingViewController(user: dependencies.user, actions)
    }
}
