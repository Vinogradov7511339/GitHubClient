//
//  CommitsCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 28.08.2021.
//

import UIKit

protocol CommitsCoordinatorDependencies {
    func commitsViewController(actions: CommitsActions) -> UIViewController
}

final class CommitsCoordinator {

    // MARK: - Private variables
    private weak var navigationController: UINavigationController?
    private let dependencies: CommitsCoordinatorDependencies

    // MARK: - Lifecycle

    init(with dependencies: CommitsCoordinatorDependencies,
         in navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }

    func start() {
        let actions = CommitsActions(showCommit: showCommit(_:))
        let controller = dependencies.commitsViewController(actions: actions)
        navigationController?.pushViewController(controller, animated: true)
    }
}

private extension CommitsCoordinator {
    func showCommit(_ commit: ExtendedCommit) {}
}

