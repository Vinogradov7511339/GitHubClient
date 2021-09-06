//
//  HomeFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

protocol HomeFlowCoordinatorDependencies {
    func homeViewController(_ actions: HomeActions) -> UIViewController
    func myIssuesViewController(_ actions: MyIssuesActions) -> UIViewController

    func openIssue(_ issue: Issue, nav: UINavigationController)
}

class HomeFlowCoordinator {

    // MARK: - Private variables

    private weak var navigationController: UINavigationController?
    private let dependencies: HomeFlowCoordinatorDependencies

    // MARK: - Lifecycle

    init(with dependencies: HomeFlowCoordinatorDependencies,
         in navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }

    func start() {
        let viewController = dependencies.homeViewController(actions())
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Home Actions
private extension HomeFlowCoordinator {
    func actions() -> HomeActions {
        .init(openIssues: openIssues)
    }
}

// MARK: - Routing
private extension HomeFlowCoordinator {
    func openIssues() {
        guard let nav = navigationController else { return }
        let actions = MyIssuesActions(showIssue: openIssue(in: nav))
        let viewController = dependencies.myIssuesViewController(actions)
        nav.pushViewController(viewController, animated: true)
    }


    func openIssue(in nav: UINavigationController) -> (Issue) -> Void {
        return { issue in self.dependencies.openIssue(issue, nav: nav) }
    }
}
