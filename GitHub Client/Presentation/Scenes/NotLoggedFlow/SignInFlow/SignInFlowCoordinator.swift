//
//  SignInFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

protocol SignInFlowCoordinatorDependencies {
    func signInViewController(with actions: LoginViewModelActions) -> UIViewController
    func openSettings(in nav: UINavigationController)
    func userLoggedIn()
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
        let actions = LoginViewModelActions(
            userLoggedIn: userLoggedIn,
            openSettings: openSettings)
        let viewController = dependencies.signInViewController(with: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func userLoggedIn() {
        dependencies.userLoggedIn()
    }
}

// MARK: - Routing
private extension SignInFlowCoordinator {
    func openSettings() {
        guard let nav = self.navigationController else { return }
        dependencies.openSettings(in: nav)
    }
}
