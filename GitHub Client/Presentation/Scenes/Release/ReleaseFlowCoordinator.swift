//
//  ReleaseFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

protocol ReleaseFlowCoordinatorDependencies {
    func releaseViewController() -> UIViewController
}

final class ReleaseFlowCoordinator {

    // MARK: - Private variables

    private weak var navigationController: UINavigationController?
    private let dependencies: ReleaseFlowCoordinatorDependencies

    // MARK: - Lifecycle

    init(with dependencies: ReleaseFlowCoordinatorDependencies,
         in navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }

    func start() {
        let controller = dependencies.releaseViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
