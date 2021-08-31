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
    func followersViewController(actions: UsersActions) -> UIViewController
    func followingViewController(actions: UsersActions) -> UIViewController

    func sendMail(email: String)
    func openLink(url: URL)
    func share(url: URL)
}

final class UserFlowCoordinator {

    // MARK: - Private variables

    private weak var navigationController: UINavigationController?
    private let dependencies: UserFlowCoordinatorDependencies

    // MARK: - Lifecycle

    init(with dependencies: UserFlowCoordinatorDependencies,
         in navigationController: UINavigationController) {
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
        .init(showRepositories: showRepositories(_:),
              showFollowers: showFollowers(_:),
              showFollowing: showFollowing(_:),
              sendEmail: dependencies.sendMail(email:),
              openLink: dependencies.openLink(url:),
              share: dependencies.share(url:),
              showRecentEvents: showRecentEvents(_:),
              showStarred: showStarred(_:),
              showGists: showGists(_:),
              showSubscriptions: showSubscriptions(_:),
              showEvents: showEvents(_:)
        )
    }
}

// MARK: - Routing
private extension UserFlowCoordinator {
    func showFollowers(_ url: URL) {}
    func showFollowing(_ url: URL) {}
    func showEvents(_ url: URL) {}
    func showRecentEvents(_ url: URL) {}
    func showStarred(_ url: URL) {}
    func showGists(_ url: URL) {}
    func showSubscriptions(_ url: URL) {}
    func showRepositories(_ url: URL) {}
}
