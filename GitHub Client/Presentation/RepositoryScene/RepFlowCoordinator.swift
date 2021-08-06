//
//  RepFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

protocol RepFlowCoordinatorDependencies {
    func makeRepViewController(actions: RepActions) -> RepViewController
    func startUserFlow(with user: User)
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
    func showStargazers(_ repository: Repository) {}
    func showForks(_ repository: Repository) {}
    func showIssues(_ repository: Repository) {}
    func showPullRequests(_ repository: Repository) {}
    func showReleases(_ repository: Repository) {}
    func showWatchers(_ repository: Repository) {}
    func showCode(_ repository: Repository) {}
    func showCommits(_ repository: Repository) {}
}
