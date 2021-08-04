//
//  LoginSceneDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class LoginSceneDIContainer {
    
    struct Dependencies {
        var userLoggedIn: (AuthenticatedUser) -> Void
    }
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func makeLoginFlowCoordinator(in window: UIWindow) -> LoginFlowCoordinator {
        return LoginFlowCoordinator(window: window, dependencies: self)
    }
}

extension LoginSceneDIContainer: LoginFlowCoordinatorDependencies {
    func userLoggedIn(authenticatedUser: AuthenticatedUser) {
        dependencies.userLoggedIn(authenticatedUser)
    }

    // MARK: - Login flow

    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController {
        return LoginViewController.create(with: makeLoginViewModel(actions: actions))
    }
    
    func makeLoginViewModel(actions: LoginViewModelActions) -> LoginViewModel {
        return LoginViewModelImpl(loginUseCase: makeLoginUseCase(), actions: actions)
    }

    func makeLoginUseCase() -> LoginUseCase {
        return LoginUseCaseImpl(repository: makeLoginRepository())
    }

    func makeLoginRepository() -> LoginRepository {
        return LoginRepositoryImpl()
    }
}
