//
//  ReleaseFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

protocol ReleaseFlowCoordinatorDependencies {
    func releaseViewController(actions: ReleaseActions) -> UIViewController
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
        let actions = ReleaseActions()
        let controller = dependencies.releaseViewController(actions: actions)
        navigationController?.pushViewController(controller, animated: true)
    }
}
