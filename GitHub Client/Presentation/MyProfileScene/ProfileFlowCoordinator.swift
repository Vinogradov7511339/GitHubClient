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
            showRepository: container.dependencies.openRepository,
            showRepositories: showRepositories,
            showStarred: showStarred,
            showOrganizations: showOrganizations,
            sendEmail: container.dependencies.sendMail,
            openLink: container.dependencies.openLink,
            share: container.dependencies.share
        )
    }

    func openSettings() {
        let viewController = SettingsGeneralViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showFollowers() {
        let actions = ItemsListActions(showDetails: container.dependencies.openUserProfile)
        let viewController = container.createFollowersViewController(actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showFollowing() {
        let actions = ItemsListActions(showDetails: container.dependencies.openUserProfile)
        let viewController = container.createFollowingViewController(actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showRepositories() {
        let actions = ItemsListActions(showDetails: container.dependencies.openRepository)
        let viewController = container.createRepositoriesViewController(actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showStarred() {
        let actions = ItemsListActions(showDetails: container.dependencies.openRepository)
        let viewController = container.createStarredViewController(actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showOrganizations() {}
}
