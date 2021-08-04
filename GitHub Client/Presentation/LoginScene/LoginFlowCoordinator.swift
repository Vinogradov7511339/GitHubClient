//
//  LoginFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

protocol LoginFlowCoordinatorDependencies {
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController
    func userLoggedIn(authenticatedUser: AuthenticatedUser)
}

class LoginFlowCoordinator {
    
    private weak var window: UIWindow?
    private let dependencies: LoginFlowCoordinatorDependencies
    
    init(window: UIWindow, dependencies: LoginFlowCoordinatorDependencies) {
        self.window = window
        self.dependencies = dependencies
    }

    func start() {
        let actions = actions()
        let viewController = dependencies.makeLoginViewController(actions: actions)
        window?.rootViewController = viewController
    }
}

extension LoginFlowCoordinator {
    func actions() -> LoginViewModelActions {
        .init(userLoggedIn: dependencies.userLoggedIn(authenticatedUser:))
    }
}
