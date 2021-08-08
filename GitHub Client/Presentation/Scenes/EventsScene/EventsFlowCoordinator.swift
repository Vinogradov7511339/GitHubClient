//
//  NotificationsFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

class EventsFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let container: EventsSceneDIContainer
    
    init(navigationController: UINavigationController, container: EventsSceneDIContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let actions = EventsActions()
        let viewController = container.makeEventsViewController(actions)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
