//
//  StarredFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

protocol StarredFlowCoordinatorDependencies {
    func makeStarredViewController(actions: StarredActions) -> StarredViewController
}

final class StarredFlowCoordinator {

    private weak var navigationController: UINavigationController?
    private let dependencies: StarredFlowCoordinatorDependencies

    init(navigationController: UINavigationController, dependencies: StarredFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let actions = StarredActions(showDetails: showDetails(repository:))
        let viewController = dependencies.makeStarredViewController(actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func showDetails(repository: Repository) {
        print("StarredFlowCoordinator showDetails")
    }
}
