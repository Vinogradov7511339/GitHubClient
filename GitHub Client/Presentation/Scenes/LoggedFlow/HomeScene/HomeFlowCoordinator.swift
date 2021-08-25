//
//  HomeFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

protocol HomeFlowCoordinatorDependencies {
    func homeViewController(_ actions: HomeActions) -> UIViewController
}

class HomeFlowCoordinator {

    // MARK: - Private variables

    private weak var navigationController: UINavigationController?
    private let dependencies: HomeFlowCoordinatorDependencies

    // MARK: - Lifecycle

    init(with dependencies: HomeFlowCoordinatorDependencies, in navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }

    func start() {
        let viewController = dependencies.homeViewController(actions())
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Home Actions
private extension HomeFlowCoordinator {
    func actions() -> HomeActions {
        .init()
    }
}

// MARK: - Routing
private extension HomeFlowCoordinator {}
