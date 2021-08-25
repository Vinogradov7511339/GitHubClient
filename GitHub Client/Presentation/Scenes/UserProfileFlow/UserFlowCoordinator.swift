//
//  StarredFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

protocol UserFlowCoordinatorDependencies {
    func profileViewController(actions: UserProfileActions) -> UIViewController
    func repositoriesViewController(actions: RepositoriesActions) -> UIViewController
    func starredViewController(actions: RepositoriesActions) -> UIViewController
    func followersViewController(actions: UsersListActions) -> UIViewController
    func followingViewController(actions: UsersListActions) -> UIViewController

    func showFollowers(_ user: User, in nav: UINavigationController)
    func showFollowing(_ user: User, in nav: UINavigationController)
    func showRepositories(_ user: User, in nav: UINavigationController)
    func showStarred(_ user: User, in nav: UINavigationController)
    func showRecentEvents(_ user: User, in nav: UINavigationController)
    func showGists(_ user: User, in nav: UINavigationController)
    func showSubscriptions(_ user: User, in nav: UINavigationController)
    func showEvents(_ user: User, in nav: UINavigationController)

    func sendMail(email: String)
    func openLink(url: URL)
    func share(url: URL)
}

final class UserFlowCoordinator {

    // MARK: - Private variables

    private weak var navigationController: UINavigationController?
    private let dependencies: UserFlowCoordinatorDependencies

    // MARK: - Lifecycle

    init(with dependencies: UserFlowCoordinatorDependencies, in navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {

        guard let nav = navigationController else { return }
        let actions = actions(in: nav)
        let viewController = dependencies.profileViewController(actions: actions)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UserProfile Actions
private extension UserFlowCoordinator {
    func actions(in nav: UINavigationController) -> UserProfileActions {
        .init(showRepositories: showFollowers(in: nav),
              showFollowers: showFollowers(in: nav),
              showFollowing: showFollowing(in: nav),
              sendEmail: dependencies.sendMail(email:),
              openLink: dependencies.openLink(url:),
              share: dependencies.share(url:),
              showRecentEvents: showRecentEvents(in: nav),
              showStarred: showStarred(in: nav),
              showGists: showGists(in: nav),
              showSubscriptions: showSubscriptions(in: nav),
              showEvents: showEvents(in: nav)
        )
    }
}

// MARK: - Routing
private extension UserFlowCoordinator {
    func showFollowers(in nav: UINavigationController) -> (User) -> Void {
        return { user in self.dependencies.showFollowers(user, in: nav) }
    }

    func showFollowing(in nav: UINavigationController) -> (User) -> Void {
        return { user in self.dependencies.showFollowing(user, in: nav) }
    }

    func showRepositories(in nav: UINavigationController) -> (User) -> Void {
        return { user in self.dependencies.showRepositories(user, in: nav) }
    }

    func showStarred(in nav: UINavigationController) -> (User) -> Void {
        return { user in self.dependencies.showStarred(user, in: nav) }
    }

    func showRecentEvents(in nav: UINavigationController) -> (User) -> Void {
        return { user in self.dependencies.showRecentEvents(user, in: nav) }
    }

    func showGists(in nav: UINavigationController) -> (User) -> Void {
        return { user in self.dependencies.showGists(user, in: nav) }
    }

    func showSubscriptions(in nav: UINavigationController) -> (User) -> Void {
        return { user in self.dependencies.showSubscriptions(user, in: nav) }
    }

    func showEvents(in nav: UINavigationController) -> (User) -> Void {
        return { user in self.dependencies.showEvents(user, in: nav) }
    }
}
