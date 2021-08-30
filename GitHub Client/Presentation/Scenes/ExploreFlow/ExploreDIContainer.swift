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
        let exploreSettingsStorage: ExploreWidgetsRequestStorage

        let showRepository: (Repository, UINavigationController) -> Void
        let showIssue: (Issue, UINavigationController) -> Void
        let showPullRequest: (PullRequest, UINavigationController) -> Void
        let showUser: (URL, UINavigationController) -> Void
    }

    // MARK: - Private variables

    private let dependencies: Dependencies
    private let exploreFactory: ExploreFactory

    // MARK: - Lifecycle

    init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
        exploreFactory = ExploreFactoryImpl(dataTransferService: dependencies.dataTransferService,
                                            searchFilterStorage: dependencies.searchFilterStorage,
                                            exploreSettingsStorage: dependencies.exploreSettingsStorage)
    }
}

// MARK: - ExploreFlowCoordinatorDependencies
extension ExploreDIContainer: ExploreFlowCoordinatorDependencies {

    func exploreViewController(exploreActions: ExploreActions,
                               _ actions: SearchResultActions) -> UIViewController {
        exploreFactory.exploreViewController(exploreActions: exploreActions, actions)
    }

    func repListViewController(_ searchQuery: String, actions: SearchListActions) -> UIViewController {
        exploreFactory.repListViewController(searchQuery, actions: actions)
    }

    func issuesViewController(_ searchQuery: String, actions: SearchListActions) -> UIViewController {
        exploreFactory.issuesViewController(searchQuery, actions: actions)
    }

    func prListViewController(_ searchQuery: String, actions: SearchListActions) -> UIViewController {
        exploreFactory.pullRequestsViewController(searchQuery, actions: actions)
    }

    func usersViewController(_ searchQuery: String, actions: SearchListActions) -> UIViewController {
        exploreFactory.usersViewController(searchQuery, actions: actions)
    }

    func showRepository(_ repository: Repository, in nav: UINavigationController) {
        dependencies.showRepository(repository, nav)
    }

    func showIssue(_ issue: Issue, in nav: UINavigationController) {
        dependencies.showIssue(issue, nav)
    }

    func showPullRequest(_ pullRequest: PullRequest, in nav: UINavigationController) {
        dependencies.showPullRequest(pullRequest, nav)
    }

    func showUser(_ user: User, in nav: UINavigationController) {
        dependencies.showUser(user.url, nav)
    }

    func searchFilterViewController() -> UIViewController {
        exploreFactory.searchFilterViewController()
    }
}
