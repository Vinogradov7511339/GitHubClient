//
//  ExploreFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

class ExploreFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ExploreConfigurator.createModule()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
