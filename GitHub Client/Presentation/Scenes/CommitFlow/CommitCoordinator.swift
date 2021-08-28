//
//  CommitCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 28.08.2021.
//

import UIKit

protocol CommitCoordinatorDependencies {
    func commitViewController(_ actions: CommitActions) -> UIViewController
}

final class CommitCoordinator {

    // MARK: - Private variables

    private weak var navigationController: UINavigationController?
    private let dependencies: CommitCoordinatorDependencies

    // MARK: - Lifecycle

    init(with dependencies: CommitCoordinatorDependencies,
         in navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }

    func start() {
        let actions = CommitActions()
        let controller = dependencies.commitViewController(actions)
        navigationController?.pushViewController(controller, animated: true)
    }
}
