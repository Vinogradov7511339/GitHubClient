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
        let viewController = container.createHomeViewController(actions: actions())
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeFlowCoordinator {
    func actions() -> HomeActions {
        .init(showIssues: showMyIssues,
              showPullRequests: showMyPullRequests,
              showDiscussions: showMyDiscussions,
              showOrganizations: container.dependencies.showOrganizations,
              showFavorites: showFavorites,
              showRepositories: container.dependencies.showRepositories,
              showRepository: container.dependencies.showRepository,
              showRecentEvent: container.dependencies.showEvent)
    }

    func showMyIssues() {}
    func showMyPullRequests() {}
    func showMyDiscussions() {}
    func showFavorites() {}
}
