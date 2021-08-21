//
//  HomeFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

class HomeFlowCoordinator {

    private weak var navigationController: UINavigationController?
    private let container: HomeDIContainer

    init(container: HomeDIContainer, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController
    }

    func start() {
        let viewController = container.homeViewController(actions: actions())
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeFlowCoordinator {
    func actions() -> HomeActions {
        .init()
    }

    func showMyIssues() {
        let controller = container.issuesViewController()
        navigationController?.pushViewController(controller, animated: true)
    }

    func showMyDiscussions() {}
}
