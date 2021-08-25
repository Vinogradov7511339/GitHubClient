//
//  ExploreDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

final class ExploreDIContainer {

    // MARK: - Dependencies

    struct Dependencies {
        let dataTransferService: DataTransferService
        let searchFilterStorage: SearchFilterStorage

        let showRepository: (Repository) -> Void
        let showIssue: (Issue) -> Void
        let showPullRequest: (PullRequest) -> Void
        let showUser: (User) -> Void
        let showOrganization: (Organization) -> Void
    }

    // MARK: - Private variables

    private let dependencies: Dependencies
    private let exploreFactory: ExploreFactory

    // MARK: - Lifecycle

    init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
        exploreFactory = ExploreFactoryImpl(dataTransferService: dependencies.dataTransferService,
                                            searchFilterStorage: dependencies.searchFilterStorage)
    }

    private func searchListActions() -> SearchListActions {
        .init(showRepository: dependencies.showRepository,
              showIssue: dependencies.showIssue,
              showPullRequest: dependencies.showPullRequest,
              showUser: dependencies.showUser,
              showOrganization: dependencies.showOrganization)
    }
}

// MARK: - ExploreFlowCoordinatorDependencies
extension ExploreDIContainer: ExploreFlowCoordinatorDependencies {
    func exploreViewController(exploreActions: ExploreActions, _ actions: SearchResultActions) -> UIViewController {
        exploreFactory.exploreViewController(exploreActions: exploreActions, actions)
    }

    func repListViewController(_ searchQuery: String) -> UIViewController {
        exploreFactory.repListViewController(searchQuery, actions: searchListActions())
    }

    func issuesViewController(_ searchQuery: String) -> UIViewController {
        exploreFactory.issuesViewController(searchQuery, actions: searchListActions())
    }

    func pullRequestsViewController(_ searchQuery: String) -> UIViewController {
        exploreFactory.pullRequestsViewController(searchQuery, actions: searchListActions())
    }

    func usersViewController(_ searchQuery: String) -> UIViewController {
        exploreFactory.usersViewController(searchQuery, actions: searchListActions())
    }

    func showRepository(_ repository: Repository) {
        dependencies.showRepository(repository)
    }

    func showIssue(_ issue: Issue) {
        dependencies.showIssue(issue)
    }

    func showPullRequest(_ pullRequest: PullRequest) {
        dependencies.showPullRequest(pullRequest)
    }

    func showUser(_ user: User) {
        dependencies.showUser(user)
    }

    func showOrganization(_ organization: Organization) {
        dependencies.showOrganization(organization)
    }

    func searchFilterViewController() -> UIViewController {
        exploreFactory.searchFilterViewController()
    }
}
