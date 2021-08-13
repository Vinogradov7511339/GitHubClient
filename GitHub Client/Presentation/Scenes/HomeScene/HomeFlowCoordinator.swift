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
              showOrganizations: container.actions.showOrganizations,
              showFavorites: showFavorites,
              showRepositories: container.actions.showRepositories,
              showRepository: container.actions.showRepository,
              showRecentEvent: container.actions.showEvent)
    }

    func showMyIssues() {
        let actions = IssuesActions(showIssue: container.actions.openIssue)
        let controller = container.createIssuesViewController(actions: actions)
        navigationController?.pushViewController(controller, animated: true)
    }

    func showMyPullRequests() {
        let actions = ItemsListActions(showDetails: container.actions.openPullRequest)
        let controller = container.createPullRequestsViewController(actions: actions)
        navigationController?.pushViewController(controller, animated: true)
    }

    func showMyDiscussions() {}

    func showFavorites() {
        let viewController = container.createFavoritesViewController()
        navigationController?.present(viewController, animated: true, completion: nil)
    }
}
