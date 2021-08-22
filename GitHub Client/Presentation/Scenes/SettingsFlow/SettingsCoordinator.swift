//
//  SettingsCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

protocol SettingsCoordinatorDependencies {
    func settingsViewController() -> UIViewController
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
        let controller = dependencies.settingsViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
