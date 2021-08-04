//
//  LoginViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

struct LoginViewModelActions {
    let userLoggedIn: (AuthenticatedUser) -> Void
}

protocol LoginViewModelInput {
    func viewDidLoad()
    func didReceive(tokenResponse: TokenResponse)
}

protocol LoginViewModelOutput {
    var error: Observable<String> { get }
}

typealias LoginViewModel = LoginViewModelInput & LoginViewModelOutput

class LoginViewModelImpl: LoginViewModel {
    
    private let loginUseCase: LoginUseCase
    private let actions: LoginViewModelActions
    
    // MARK: - Output
    var error: Observable<String> = Observable("")
    
    init(loginUseCase: LoginUseCase, actions: LoginViewModelActions) {
        self.loginUseCase = loginUseCase
        self.actions = actions
    }
}

// MARK: - LoginViewModelInput
extension LoginViewModelImpl {
    func viewDidLoad() {}

    func didReceive(tokenResponse: TokenResponse) {
        loginUseCase.fetch(tokenResponse: tokenResponse) { result in
            switch result {
            case .success(let userInfo):
                self.finishLoginFlow(with: userInfo)
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
}

// MARK: - Private
private extension LoginViewModelImpl {
    func finishLoginFlow(with userInfo: AuthenticatedUser) {
        actions.userLoggedIn(userInfo)
    }

    func handleError(_ error: Error) {
        let errorTempName = NSLocalizedString("TempError", comment: "")
        self.error.value = errorTempName
    }
}
