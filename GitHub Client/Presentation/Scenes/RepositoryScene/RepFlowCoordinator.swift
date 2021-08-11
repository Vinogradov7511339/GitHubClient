//
//  RepFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

protocol RepFlowCoordinatorDependencies {
    func makeRepViewController(actions: RepActions) -> RepViewController
    func makeStargazersViewController(for repository: Repository, actions: ItemsListActions<User>) -> ItemsListViewController<User>
    func makeForksViewController(for repository: Repository, actions: ItemsListActions<Repository>) -> ItemsListViewController<Repository>
    func makeIssuesViewController(for repository: Repository, actions: ItemsListActions<Issue>) -> ItemsListViewController<Issue>
    func makePullRequestsViewController(for repository: Repository, actions: ItemsListActions<PullRequest>) -> ItemsListViewController<PullRequest>
    func makeReleasesViewController(for repository: Repository, actions: ItemsListActions<Release>) -> ItemsListViewController<Release>
    func makeCommitsViewController(for repository: Repository, actions: ItemsListActions<Commit>) -> ItemsListViewController<Commit>
    func startUserFlow(with user: User)
    func startRepFlow(with repository: Repository)
    func openLink(url: URL)
    func share(url: URL)
}

final class RepFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: RepFlowCoordinatorDependencies
    
    init(navigationController: UINavigationController, dependencies: RepFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = actions()
        let viewController = dependencies.makeRepViewController(actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension RepFlowCoordinator {
    func actions() -> RepActions {
        .init(
            showStargazers: showStargazers(_:),
            showForks: showForks(_:),
            showOwner: dependencies.startUserFlow(with:),
            showIssues: showIssues(_:),
            showPullRequests: showPullRequests(_:),
            showReleases: showReleases(_:),
            showWatchers: showWatchers(_:),
            showCode: showCode(_:),
            showCommits: showCommits(_:),
            openLink: dependencies.openLink(url:),
            share: dependencies.share(url:)
        )
    }

    func showStargazers(_ repository: Repository) {
        let actions = ItemsListActions(showDetails: dependencies.startUserFlow(with:))
        let viewController = dependencies.makeStargazersViewController(for: repository, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showForks(_ repository: Repository) {
        let actions = ItemsListActions(showDetails: dependencies.startRepFlow(with:))
        let viewController = dependencies.makeForksViewController(for: repository, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showIssues(_ repository: Repository) {
        let actions = ItemsListActions(showDetails: startIssueFlow(_:))
        let viewController = dependencies.makeIssuesViewController(for: repository, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showPullRequests(_ repository: Repository) {
        let actions = ItemsListActions(showDetails: startPullRequestFlow(_:))
        let viewController = dependencies.makePullRequestsViewController(for: repository, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showReleases(_ repository: Repository) {
        let actions = ItemsListActions(showDetails: startReleaseFlow(_:))
        let viewController = dependencies.makeReleasesViewController(for: repository, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showWatchers(_ repository: Repository) {}
    func showCode(_ repository: Repository) {}

    func showCommits(_ repository: Repository) {
        let actions = ItemsListActions(showDetails: startCommitsFlow(_:))
        let viewController = dependencies.makeCommitsViewController(for: repository, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

private extension RepFlowCoordinator {
    func startIssueFlow(_ issue: Issue) {}
    func startCommitsFlow(_ commit: Commit) {}
    func startReleaseFlow(_ release: Release) {}
    func startPullRequestFlow(_ pullRequest: PullRequest) {}
}
