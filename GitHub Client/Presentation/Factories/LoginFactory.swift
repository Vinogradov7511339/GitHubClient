//
//  LoginFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

protocol LoginFactory {
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController
}

final class LoginFactoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - LoginFactory
extension LoginFactoryImpl: LoginFactory {
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController {
        return LoginViewController.create(with: makeLoginViewModel(actions: actions))
    }
}

private extension LoginFactoryImpl {
    func makeLoginViewModel(actions: LoginViewModelActions) -> LoginViewModel {
        return LoginViewModelImpl(loginUseCase: makeLoginUseCase(), actions: actions)
    }

    func makeLoginUseCase() -> LoginUseCase {
        return LoginUseCaseImpl(repository: makeLoginRepository())
    }

    func makeLoginRepository() -> LoginRepository {
        return LoginRepositoryImpl(dataTransferService: dataTransferService)
    }
}
