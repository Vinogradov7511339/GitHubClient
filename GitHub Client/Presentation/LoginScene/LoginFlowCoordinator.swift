//
//  LoginFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

protocol LoginFlowCoordinatorDependencies {
    func tabBar() -> UITabBarController
    func configure(_ controller: UITabBarController)
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController
    func userLoggedIn()
}

final class LoginFlowCoordinator {

    // MARK: - Privae variables

    private let window: UIWindow
    private let dependencies: LoginFlowCoordinatorDependencies
    private let tabBarController: UITabBarController

    init(in window: UIWindow, dependencies: LoginFlowCoordinatorDependencies) {
        self.window = window
        self.dependencies = dependencies
        self.tabBarController = dependencies.tabBar()
    }

    func start() {
        dependencies.configure(tabBarController)

        // login animation
        if let previousController = window.rootViewController {
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft) {
                self.window.subviews.forEach { $0.removeFromSuperview() }
                self.window.rootViewController = self.tabBarController
            } completion: { _ in
                previousController.dismiss(animated: false, completion: {
                    previousController.view.removeFromSuperview()
                })
            }
        } else {
            window.rootViewController = tabBarController
        }
    }
}

extension LoginFlowCoordinator {
    func actions() -> LoginViewModelActions {
        .init(userLoggedIn: dependencies.userLoggedIn)
    }
}
