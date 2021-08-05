//
//  LoginSceneDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class LoginSceneDIContainer {
    
    struct Dependencies {
        var userLoggedIn: () -> Void
    }
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
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
        return LoginViewController.create(with: makeLoginViewModel(actions: actions))
    }
    
    func makeLoginViewModel(actions: LoginViewModelActions) -> LoginViewModel {
        return LoginViewModelImpl(loginUseCase: makeLoginUseCase(), actions: actions)
    }

    func makeLoginUseCase() -> LoginUseCase {
        return LoginUseCaseImpl()
    }
}
