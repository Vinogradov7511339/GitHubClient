//
//  LoginFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

protocol LoginFlowCoordinatorDependencies {
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController
    func userLoggedIn()
}

class LoginFlowCoordinator {
    
    private let window: UIWindow
    private let dependencies: LoginFlowCoordinatorDependencies
    
    init(in window: UIWindow, dependencies: LoginFlowCoordinatorDependencies) {
        self.window = window
        self.dependencies = dependencies
    }

    func start() {
        let actions = actions()
        let viewController = dependencies.makeLoginViewController(actions: actions)
        // login animation
        if let previousController = window.rootViewController {
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft) {
                self.window.subviews.forEach { $0.removeFromSuperview() }
                self.window.rootViewController = viewController
            } completion: { _ in
                previousController.dismiss(animated: false, completion: {
                    previousController.view.removeFromSuperview()
                })
            }
        } else {
            window.rootViewController = viewController
        }
    }
}

extension LoginFlowCoordinator {
    func actions() -> LoginViewModelActions {
        .init(userLoggedIn: dependencies.userLoggedIn)
    }
}
