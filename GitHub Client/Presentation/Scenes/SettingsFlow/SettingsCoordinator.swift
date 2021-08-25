//
//  SettingsCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

protocol SettingsCoordinatorDependencies {
    func logout()

    func settingsViewController(_ actions: SettingsActions) -> UIViewController
    func accountViewController(_ actions: AccountActions) -> UIViewController
}

final class SettingsCoordinator {

    // MARK: - Private variables

    private weak var navigationController: UINavigationController?
    private var dependencies: SettingsCoordinatorDependencies

    // MARK: - Lifecycle

    init(with dependencies: SettingsCoordinatorDependencies,
         in navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let actions = SettingsActions(showAccount: openAccountSettings)
        let controller = dependencies.settingsViewController(actions)
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - Routing
private extension SettingsCoordinator {
    func openAccountSettings() {
        let actions = AccountActions(logout: dependencies.logout)
        let controller = dependencies.accountViewController(actions)
        navigationController?.pushViewController(controller, animated: true)
    }
}
