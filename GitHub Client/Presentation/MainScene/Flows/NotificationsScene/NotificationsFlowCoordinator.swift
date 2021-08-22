//
//  ExploreFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

class NotificationsFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let container: NotificationsDIContainer
    
    init(container: NotificationsDIContainer, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController
    }
    
    func start() {
        let actions = NotificationsActions()
        let viewController = container.makeNotificationsViewController(actions)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
