//
//  LoginSceneDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class LoginSceneDIContainer {
    
    struct Dependencies {
        let dataTransferService: DataTransferService
        var userLoggedIn: () -> Void
    }
    
    let dependencies: Dependencies
    private let loginFactory: LoginFactory
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.loginFactory = LoginFactoryImpl(dataTransferService: dependencies.dataTransferService)
    }

    func makeLoginFlowCoordinator(in window: UIWindow) -> LoginFlowCoordinator {
        return LoginFlowCoordinator(in: window, dependencies: self)
    }
}

extension LoginSceneDIContainer: LoginFlowCoordinatorDependencies {
    func userLoggedIn() {
        dependencies.userLoggedIn()
    }

    // MARK: - Login flow

    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController {
        loginFactory.makeLoginViewController(actions: actions)
    }
}
