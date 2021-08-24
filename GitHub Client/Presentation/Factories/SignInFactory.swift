//
//  SignInFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

protocol SignInFactory {
    func signInViewController(_ actions: LoginViewModelActions) -> UIViewController
}

final class SignInFactoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - SignInFactory
extension SignInFactoryImpl: SignInFactory {
    func signInViewController(_ actions: LoginViewModelActions) -> UIViewController {
        OnboardingViewController.create(with: loginViewModel(actions))
    }
}

// MARK: - Private
private extension SignInFactoryImpl {
    func loginViewModel(_ actions: LoginViewModelActions) -> LoginViewModel {
        LoginViewModelImpl(loginUseCase: loginUseCase, actions: actions)
    }

    var loginUseCase: LoginUseCase {
        LoginUseCaseImpl(repository: loginRepository)
    }

    var loginRepository: LoginRepository {
        LoginRepositoryImpl(dataTransferService: dataTransferService)
    }
}
