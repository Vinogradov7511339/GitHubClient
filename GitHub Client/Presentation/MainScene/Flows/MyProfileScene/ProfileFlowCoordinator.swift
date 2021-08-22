//
//  ProfileFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

class ProfileFlowCoordinator {

    private weak var navigationController: UINavigationController?
    private let container: ProfileDIContainer

    init(in navigationController: UINavigationController, with container: ProfileDIContainer) {
        self.navigationController = navigationController
        self.container = container
    }

    func start() {
        let controller = container.createProfileViewController(actions())
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ProfileFlowCoordinator {
    func actions() -> ProfileActions {
        .init(
            openSettings: openSettings,
            showFollowers: showFollowers,
            showFollowing: showFollowing,
            showRepository: container.actions.openRepository,
            showRepositories: showRepositories,
            showStarred: showStarred,
            showOrganizations: showOrganizations,
            showSubscriptions: showSubscriptions,
            sendEmail: container.actions.sendMail,
            openLink: container.actions.openLink,
            share: container.actions.share
        )
    }

    func openSettings() {
        if let navigation = navigationController {
            container.openSettings(in: navigation)
        } else {
            assert(false, "no navigation")
        }
    }

    func showFollowers() {
        let actions = MyUsersViewModelActions(showUser: container.actions.openUserProfile)
        let viewController = container.createFollowersViewController(actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showSubscriptions() {
        let viewController = container.createSubscriptionsViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showFollowing() {
        let actions = MyUsersViewModelActions(showUser: container.actions.openUserProfile)
        let viewController = container.createFollowingViewController(actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showRepositories() {
        let actions = MyRepositoriesActions(showRepository: container.actions.openRepository)
        let viewController = container.createRepositoriesViewController(actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showStarred() {
        let actions = MyRepositoriesActions(showRepository: container.actions.openRepository)
        let viewController = container.createStarredViewController(actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showOrganizations() {}
}
