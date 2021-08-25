//
//  ExploreFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

protocol ExploreFlowCoordinatorDependencies {
    func exploreViewController(exploreActions: ExploreActions,
                               _ actions: SearchResultActions) -> UIViewController
    func searchFilterViewController() -> UIViewController

    func repListViewController(_ searchQuery: String, actions: SearchListActions) -> UIViewController
    func issuesViewController(_ searchQuery: String, actions: SearchListActions) -> UIViewController
    func pullRequestsViewController(_ searchQuery: String, actions: SearchListActions) -> UIViewController
    func usersViewController(_ searchQuery: String, actions: SearchListActions) -> UIViewController

    func showRepository(_ repository: Repository, in nav: UINavigationController)
    func showIssue(_ issue: Issue, in nav: UINavigationController)
    func showPullRequest(_ pullRequest: PullRequest, in nav: UINavigationController)
    func showUser(_ user: User, in nav: UINavigationController)
}

final class ExploreFlowCoordinator {

    // MARK: - Private variables

    private weak var navigationController: UINavigationController?
    private let dependencies: ExploreFlowCoordinatorDependencies

    // MARK: - Lifecycle

    init(with dependencies: ExploreFlowCoordinatorDependencies, in navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }

    func start() {
        let actions = SearchResultActions(loadRepList: showRepList(_:),
                                          loadIssues: showIssues(_:),
                                          loadPRList: showPRList(_:),
                                          loadUsers: showUsers(_:),
                                          showRepository: showRepository(_:),
                                          showIssue: showIssue(_:),
                                          showPullRequest: showPullRequest(_:),
                                          showUser: showUser(_:))
        let exploreActions = ExploreActions(openFilter: openFilter,
                                            openRepository: showRepository(_:))
        let viewController = dependencies.exploreViewController(exploreActions: exploreActions, actions)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Search actions
private extension ExploreFlowCoordinator {
    func searchListActions() -> SearchListActions {
        SearchListActions(showRepository: showRepository(_:),
                          showIssue: showIssue(_:),
                          showPullRequest: showPullRequest(_:),
                          showUser: showUser(_:))
    }
}

// MARK: - Details Routing
private extension ExploreFlowCoordinator {
    func showRepository(_ repository: Repository) {
        guard let nav = navigationController else { return }
        dependencies.showRepository(repository, in: nav)
    }

    func showIssue(_ issue: Issue) {
        guard let nav = navigationController else { return }
        dependencies.showIssue(issue, in: nav)

    }

    func showPullRequest(_ pullRequest: PullRequest) {
        guard let nav = navigationController else { return }
        dependencies.showPullRequest(pullRequest, in: nav)
    }

    func showUser(_ user: User) {
        guard let nav = navigationController else { return }
        dependencies.showUser(user, in: nav)
    }
}

// MARK: - Routing
private extension ExploreFlowCoordinator {
    func showRepList(_ searchQuery: String) {
        let viewController = dependencies.repListViewController(searchQuery, actions: searchListActions())
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showIssues(_ searchQuery: String) {
        let viewController = dependencies.issuesViewController(searchQuery, actions: searchListActions())
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showPRList(_ searchQuery: String) {
        let viewController = dependencies.pullRequestsViewController(searchQuery, actions: searchListActions())
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showUsers(_ searchQuery: String) {
        let viewController = dependencies.usersViewController(searchQuery, actions: searchListActions())
        navigationController?.pushViewController(viewController, animated: true)
    }

    func openFilter() {
        let viewController = dependencies.searchFilterViewController()
        let nav = UINavigationController(rootViewController: viewController)
        navigationController?.viewControllers.last?.present(nav, animated: true, completion: nil)
    }
}
