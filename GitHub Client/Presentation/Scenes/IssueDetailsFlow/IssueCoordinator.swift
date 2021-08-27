//
//  IssueCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.08.2021.
//

import UIKit

protocol IssueCoordinatorDependencies {
    func issueViewController() -> UIViewController
}

final class IssueCoordinator {

    // MARK: - Private variables

    private weak var navigationController: UINavigationController?
    private let dependencies: IssueCoordinatorDependencies

    // MARK: - Lifecycle

    init(with dependencies: IssueCoordinatorDependencies, in navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }

    func start() {
        let controller = dependencies.issueViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
