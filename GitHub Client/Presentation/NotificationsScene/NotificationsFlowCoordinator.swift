//
//  NotificationsFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

class NotificationsFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = NotificationsConfigurator.createModule()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
