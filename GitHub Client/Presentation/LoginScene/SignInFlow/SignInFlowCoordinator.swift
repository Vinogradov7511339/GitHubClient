//
//  SignInFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

protocol SignInFlowCoordinatorDependencies {
    func signInViewController() -> UIViewController
}

final class SignInFlowCoordinator {

    // MARK: - Private variables

    private weak var navigationController: UINavigationController?
    private let dependencies: SignInFlowCoordinatorDependencies

    // MARK: - Lifecycle

    init(_ navigationController: UINavigationController,
         dependencies: SignInFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        
        let viewController = dependencies.signInViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
