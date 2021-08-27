//
//  PullRequestCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.08.2021.
//

import UIKit

protocol PullRequestCoordinatorDependencies {
    func prViewController(actions: PRActions) -> UIViewController
}

final class PullRequestCoordinator {

    // MARK: - Private variables
    private weak var navigationController: UINavigationController?
    private let dependencies: PullRequestCoordinatorDependencies

    // MARK: - Lifecycle

    init(with dependencies: PullRequestCoordinatorDependencies,
         in navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }

    func start() {
        let actions = PRActions()
        let controller = dependencies.prViewController(actions: actions)
        navigationController?.pushViewController(controller, animated: true)
    }
}
