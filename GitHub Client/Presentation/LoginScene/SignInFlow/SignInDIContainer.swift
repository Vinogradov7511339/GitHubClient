//
//  SignInDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

final class SignInDIContainer {

    // MARK: - Dependencies

    struct Dependencies {
        let dataTransferService: DataTransferService
        let login: () -> Void
    }

    // MARK: - Private variables

    private let dependencies: Dependencies
    private let signInFactory: SignInFactory
    private let settingsFactory: SettingsFactory

    // MARK: - Lifecycle

    init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
        signInFactory = SignInFactoryImpl(dataTransferService: dependencies.dataTransferService)
        settingsFactory = SettingsFactoryImpl()
    }
}

// MARK: - SignInFlowCoordinatorDependencies
extension SignInDIContainer: SignInFlowCoordinatorDependencies {
    func signInViewController() -> UIViewController {
        let loginActions = LoginViewModelActions(userLoggedIn: dependencies.login)
        return signInFactory.signInViewController(loginActions)
    }
}
