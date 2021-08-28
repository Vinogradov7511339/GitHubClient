//
//  CommitsCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 28.08.2021.
//

import UIKit

protocol CommitsCoordinatorDependencies {
    func commitsViewController(actions: CommitsActions) -> UIViewController

    func show(_ commit: URL, in nav: UINavigationController)
}

final class CommitsCoordinator {

    // MARK: - Private variables

    private weak var navigationController: UINavigationController?
    private let dependencies: CommitsCoordinatorDependencies

    // MARK: - Lifecycle

    init(with dependencies: CommitsCoordinatorDependencies,
         in navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }

    func start() {
        guard let nav = navigationController else { return }
        let actions = CommitsActions(showCommit: showCommit(in: nav))
        let controller = dependencies.commitsViewController(actions: actions)
        navigationController?.pushViewController(controller, animated: true)
    }
}

private extension CommitsCoordinator {
    func showCommit(in nav: UINavigationController) -> (URL) -> Void {
        return { commit in self.dependencies.show(commit, in: nav) }
    }
}
