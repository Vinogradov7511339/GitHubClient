//
//  ExploreFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

protocol NotificationsFlowCoordinatorDelegate {
    func notificationsViewController(_ actions: NotificationsActions) -> UIViewController
}

class NotificationsFlowCoordinator {

    // MARK: - Private variables

    private weak var navigationController: UINavigationController?
    private let dependencies: NotificationsFlowCoordinatorDelegate

    // MARK: - Lifecycle

    init(with dependencies: NotificationsFlowCoordinatorDelegate, in navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }
    
    func start() {
        let actions = NotificationsActions()
        let viewController = dependencies.notificationsViewController(actions)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
