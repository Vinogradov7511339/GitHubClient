//
//  ProfileFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

protocol ProfileFlowCoordinatorDependencies {
    func profileViewController(_ actions: ProfileActions) -> UIViewController
    func followersViewController(_ actions: MyUsersViewModelActions) -> UIViewController
    func followingViewController(_ actions: MyUsersViewModelActions) -> UIViewController
    func subscriptionsViewController() -> UIViewController
    func showRepositories(_ actions: MyRepositoriesActions) -> UIViewController
    func showStarred(_ actions: MyRepositoriesActions) -> UIViewController

    func openSettings(in nav: UINavigationController)
    func openRepository(_ repository: Repository, in nav: UINavigationController)
    func openProfile(_ user: User, in nav: UINavigationController)

    func share(_ url: URL)
    func open(_ link: URL)
    func send(_ email: String)
}

class ProfileFlowCoordinator {

    // MARK: - Private variables

    private weak var navigationController: UINavigationController?
    private let dependencies: ProfileFlowCoordinatorDependencies

    // MARK: - Lifecycle

    init(with dependencies: ProfileFlowCoordinatorDependencies, in navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }

    func start() {
        guard let nav = navigationController else { return }
        let controller = dependencies.profileViewController(actions(in: nav))
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - Currying functions
private extension ProfileFlowCoordinator {
    func openRepository(in nav: UINavigationController) -> (Repository) -> Void {
        return { repository in self.dependencies.openRepository(repository, in: nav) }
    }

    func openProfile(in nav: UINavigationController) -> (User) -> Void {
        return { user in self.dependencies.openProfile(user, in: nav) }
    }

}

// MARK: - Profile Actions
private extension ProfileFlowCoordinator {
    func actions(in nav: UINavigationController) -> ProfileActions {
        .init(
            openSettings: openSettings,
            showFollowers: showFollowers,
            showFollowing: showFollowing,
            showRepository: openRepository(in: nav),
            showRepositories: showRepositories,
            showStarred: showStarred,
            showSubscriptions: showSubscriptions,
            sendEmail: dependencies.send,
            openLink: dependencies.open,
            share: dependencies.share
        )
    }
}

// MARK: - Routing
private extension ProfileFlowCoordinator {
    func openSettings() {
        guard let nav = navigationController else { return }
        dependencies.openSettings(in: nav)
    }

    func showFollowers() {
        guard let nav = navigationController else { return }
        let actions = MyUsersViewModelActions(showUser: openProfile(in: nav))
        let viewController = dependencies.followersViewController(actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showFollowing() {
        guard let nav = navigationController else { return }
        let actions = MyUsersViewModelActions(showUser: openProfile(in: nav))
        let viewController = dependencies.followingViewController(actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showSubscriptions() {
        let viewController = dependencies.subscriptionsViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showRepositories() {
        guard let nav = navigationController else { return }
        let actions = MyRepositoriesActions(showRepository: openRepository(in: nav))
        let viewController = dependencies.showRepositories(actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showStarred() {
        guard let nav = navigationController else { return }
        let actions = MyRepositoriesActions(showRepository: openRepository(in: nav))
        let viewController = dependencies.showStarred(actions)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
