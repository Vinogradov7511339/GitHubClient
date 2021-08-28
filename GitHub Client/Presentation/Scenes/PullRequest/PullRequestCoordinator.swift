//
//  PullRequestCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.08.2021.
//

import UIKit

protocol PullRequestCoordinatorDependencies {
    func prViewController(actions: PRActions) -> UIViewController
    func diffViewController(_ url: URL, actions: DiffActions) -> UIViewController

    func showCommits(_ url: URL, in nav: UINavigationController)
}

final class PullRequestCoordinator {

    // MARK: - Private variables
    private weak var navigationController: UINavigationController?
    private let dependencies: PullRequestCoordinatorDependencies

    // MARK: - Lifecycle

    init(with dependencies: PullRequestCoordinatorDependencies,
         in navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }

    func start() {
        guard let nav = navigationController else { return }
        let actions = PRActions(showDiff: showDiff(_:),
                                showCommits: showCommits(in: nav))
        let controller = dependencies.prViewController(actions: actions)
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - Routing
private extension PullRequestCoordinator {
    func showDiff(_ diffUrl: URL) {
        let actions = DiffActions()
        let controller = dependencies.diffViewController(diffUrl, actions: actions)
        navigationController?.pushViewController(controller, animated: true)
    }

    func showCommits(in nav: UINavigationController) -> (URL) -> Void {
        return { url in self.dependencies.showCommits(url, in: nav)}
    }
}
