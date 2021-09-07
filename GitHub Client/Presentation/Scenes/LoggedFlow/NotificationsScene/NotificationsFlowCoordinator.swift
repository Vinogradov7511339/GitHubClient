//
//  ExploreFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

protocol NotificationsFlowCoordinatorDelegate {
    func notificationsViewController(_ actions: NotificationsActions) -> UIViewController

    func openIssue(_ url: URL, in nav: UINavigationController)
}

class NotificationsFlowCoordinator {

    // MARK: - Private variables

    private weak var navigationController: UINavigationController?
    private let dependencies: NotificationsFlowCoordinatorDelegate

    // MARK: - Lifecycle

    init(with dependencies: NotificationsFlowCoordinatorDelegate, in navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }
    
    func start() {
        guard let nav = navigationController else { return }
        let actions = NotificationsActions(openIssue: openIssue(in: nav))
        let viewController = dependencies.notificationsViewController(actions)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Routing
private extension NotificationsFlowCoordinator {
    func openIssue(in nav: UINavigationController) -> (URL) -> Void {
        return { url in self.dependencies.openIssue(url, in: nav) }
    }
}
