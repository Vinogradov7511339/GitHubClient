//
//  SettingsCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

protocol SettingsCoordinatorDependencies {
    var logout: () -> Void { get }

    func settingsViewController(_ actions: SettingsActions) -> UIViewController
    func accountViewController(_ actions: AccountActions) -> UIViewController
}

final class SettingsCoordinator {

    private weak var navigationController: UINavigationController?
    private var dependencies: SettingsCoordinatorDependencies

    init(in navigationController: UINavigationController,
         with dependencies: SettingsCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let actions = SettingsActions(showAccount: openAccountSettings)
        let controller = dependencies.settingsViewController(actions)
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - Coordinate
private extension SettingsCoordinator {
    func openAccountSettings() {
        let actions = AccountActions(logout: dependencies.logout)
        let controller = dependencies.accountViewController(actions)
        navigationController?.pushViewController(controller, animated: true)
    }
}
