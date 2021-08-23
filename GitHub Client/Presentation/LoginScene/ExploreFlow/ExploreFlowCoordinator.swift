//
//  ExploreFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

protocol ExploreFlowCoordinatorDependencies {
    func exploreViewController(_ actions: SearchResultActions) -> UIViewController

    func repListViewController(_ searchQuery: String) -> UIViewController
    func issuesViewController(_ searchQuery: String) -> UIViewController
    func pullRequestsViewController(_ searchQuery: String) -> UIViewController
    func usersViewController(_ searchQuery: String) -> UIViewController
    func organizationsViewController(_ searchQuery: String) -> UIViewController

    func showRepository(_ repository: Repository)
    func showIssue(_ issue: Issue)
    func showPullRequest(_ pullRequest: PullRequest)
    func showUser(_ user: User)
    func showOrganization(_ organization: Organization)
}

final class ExploreFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: ExploreFlowCoordinatorDependencies

    init(_ navigationController: UINavigationController, dependencies: ExploreFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let actions = SearchResultActions(loadRepList: showRepList(_:),
                                          loadIssues: showIssues(_:),
                                          loadPRList: showPRList(_:),
                                          loadUsers: showUsers(_:),
                                          loadOrgList: showOrgList(_:),
                                          showRepository: dependencies.showRepository(_:),
                                          showIssue: dependencies.showIssue(_:),
                                          showPullRequest: dependencies.showPullRequest(_:),
                                          showUser: dependencies.showUser(_:),
                                          showOrganization: dependencies.showOrganization(_:))
        let viewController = dependencies.exploreViewController(actions)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Routing
private extension ExploreFlowCoordinator {
    func showRepList(_ searchQuery: String) {
        let viewController = dependencies.repListViewController(searchQuery)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showIssues(_ searchQuery: String) {
        let viewController = dependencies.issuesViewController(searchQuery)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showPRList(_ searchQuery: String) {
        let viewController = dependencies.pullRequestsViewController(searchQuery)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showUsers(_ searchQuery: String) {
        let viewController = dependencies.usersViewController(searchQuery)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showOrgList(_ searchQuery: String) {
        let viewController = dependencies.organizationsViewController(searchQuery)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
