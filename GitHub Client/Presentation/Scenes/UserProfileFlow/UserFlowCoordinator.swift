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
    func followersViewController(_ url: URL, actions: UsersActions) -> UIViewController
    func followingViewController(_ url: URL, actions: UsersActions) -> UIViewController
    func eventsViewController(_ eventsUrl: URL,
                              _ recivedEventsUrl: URL,
                              actions: EventsActions) -> UIViewController

    func sendMail(email: String)
    func openLink(url: URL)
    func share(url: URL)

    func showUser(_ url: URL, in nav: UINavigationController)
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
        .init(showFollowers: showFollowers(_:),
              showFollowing: showFollowing(_:),
              sendEmail: dependencies.sendMail(email:),
              openLink: dependencies.openLink(url:),
              share: dependencies.share(url:),
              showRepositories: showRepositories(_:),
              showStarred: showStarred(_:),
              showGists: showGists(_:),
              showEvents: showEvents,
              showSubscriptions: showSubscriptions(_:)
        )
    }
}

// MARK: - Routing
private extension UserFlowCoordinator {
    func showFollowers(_ url: URL) {
        guard let nav = navigationController else { return }
        let actions = UsersActions(showUser: showUser(in: nav))
        let viewController = dependencies.followersViewController(url, actions: actions)
        nav.pushViewController(viewController, animated: true)
    }
    func showFollowing(_ url: URL) {
        guard let nav = navigationController else { return }
        let actions = UsersActions(showUser: showUser(in: nav))
        let viewController = dependencies.followingViewController(url, actions: actions)
        nav.pushViewController(viewController, animated: true)
    }

    func showEvents(_ events: URL, _ recentEvents: URL) {
        let actions = EventsActions()
        let viewController = dependencies.eventsViewController(events, recentEvents, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showStarred(_ url: URL) {}
    func showGists(_ url: URL) {}
    func showSubscriptions(_ url: URL) {}
    func showRepositories(_ url: URL) {}

    func showUser(in nav: UINavigationController) -> (URL) -> Void {
        return { url in self.dependencies.showUser(url, in: nav) }
    }
}
