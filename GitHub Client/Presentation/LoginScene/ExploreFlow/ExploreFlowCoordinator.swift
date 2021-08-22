//
//  ExploreFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

protocol ExploreFlowCoordinatorDependencies {
    func exploreViewController() -> UIViewController
}

final class ExploreFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: ExploreFlowCoordinatorDependencies

    init(_ navigationController: UINavigationController, dependencies: ExploreFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let viewController = dependencies.exploreViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
