//
//  ProfileFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

protocol ProfileFlowCoordinatorDependencies {
    func profileViewController(actions: ProfileActions) -> UIViewController
    func followersViewController(_ url: URL, actions: UsersActions) -> UIViewController
    func followingViewController(_ url: URL, actions: UsersActions) -> UIViewController
    func subscriptionsViewController(_ actions: MySubscriptionsActions) -> UIViewController
    func eventsViewController(events: URL, received: URL, _ actions: EventsActions) -> UIViewController
    func showRepositories(_ url: URL, actions: RepositoriesActions) -> UIViewController
    func showStarred(_ url: URL, actions: RepositoriesActions) -> UIViewController

    func openSettings(in nav: UINavigationController)
    func openRepository(_ repository: URL, in nav: UINavigationController)
    func openProfile(_ user: URL, in nav: UINavigationController)

    func share(_ url: URL)
    func open(_ link: URL)
    func send(_ email: String)
}

class ProfileFlowCoordinator {

    // MARK: - Private variables

    private weak var navigationController: UINavigationController?
    private let dependencies: ProfileFlowCoordinatorDependencies

    // MARK: - Lifecycle

    init(with dependencies: ProfileFlowCoordinatorDependencies,
         in navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }

    func start() {
        guard let nav = navigationController else { return }
        let controller = dependencies.profileViewController(actions: actions(in: nav))
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - Currying functions
private extension ProfileFlowCoordinator {
    func openRepository(in nav: UINavigationController) -> (URL) -> Void {
        return { repository in self.dependencies.openRepository(repository, in: nav) }
    }

    func openProfile(in nav: UINavigationController) -> (URL) -> Void {
        return { user in self.dependencies.openProfile(user, in: nav) }
    }

}

// MARK: - Profile Actions
private extension ProfileFlowCoordinator {
    func actions(in nav: UINavigationController) -> ProfileActions {
        .init(
            openSettings: openSettings,
            showFollowers: showFollowers(_:),
            showFollowing: showFollowing(_:),
            showRepositories: showRepositories(_:),
            showStarred: showStarred(_:),
            showSubscriptions: showSubscriptions,
            showEvents: showEvents,
            sendEmail: dependencies.send,
            openLink: dependencies.open,
            share: dependencies.share,
            showRepository: showRepository(in: nav),
            showUser: showUser(in: nav)
        )
    }
}

// MARK: - Routing
private extension ProfileFlowCoordinator {
    func openSettings() {
        guard let nav = navigationController else { return }
        dependencies.openSettings(in: nav)
    }

    func showFollowers(_ url: URL) {
        guard let nav = navigationController else { return }
        let actions = UsersActions(showUser: openProfile(in: nav))
        let viewController = dependencies.followersViewController(url, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showFollowing(_ url: URL) {
        guard let nav = navigationController else { return }
        let actions = UsersActions(showUser: openProfile(in: nav))
        let viewController = dependencies.followingViewController(url, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showSubscriptions() {
        let actions = MySubscriptionsActions()
        let viewController = dependencies.subscriptionsViewController(actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showRepositories(_ url: URL) {
        guard let nav = navigationController else { return }
        let actions = RepositoriesActions(showRepository: openRepository(in: nav))
        let viewController = dependencies.showRepositories(url, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showStarred(_ url: URL) {
        guard let nav = navigationController else { return }
        let actions = RepositoriesActions(showRepository: openRepository(in: nav))
        let viewController = dependencies.showStarred(url, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showEvents(_ events: URL, _ received: URL) {
        let actions = EventsActions()
        let viewController = dependencies.eventsViewController(events: events, received: received, actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showRepository(in nav: UINavigationController) -> (URL) -> Void {
        return { url in self.dependencies.openRepository(url, in: nav) }
    }

    func showUser(in nav: UINavigationController) -> (URL) -> Void {
        return { url in self.dependencies.openProfile(url, in: nav) }
    }
}
