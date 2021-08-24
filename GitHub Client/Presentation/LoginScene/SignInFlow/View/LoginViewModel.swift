//
//  LoginViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

struct LoginViewModelActions {
    let userLoggedIn: () -> Void
}

protocol LoginViewModelInput {
    func viewDidLoad()
    func fetchToken(authCode: String)
}

protocol LoginViewModelOutput {
    var error: Observable<String> { get }
    var introScenes: [IntroScene] { get }
}

typealias LoginViewModel = LoginViewModelInput & LoginViewModelOutput

class LoginViewModelImpl: LoginViewModel {
    
    private let loginUseCase: LoginUseCase
    private let actions: LoginViewModelActions
    
    // MARK: - Output
    var error: Observable<String> = Observable("")
    var introScenes: [IntroScene] = [
        IntroScene(name: "First",
                   mainTitle: "Hey there! Welcome to our App",
                   animationName: String.OnboardingAnimation.favorites),
        IntroScene(name: "Second",
                   mainTitle: "Please bear with us for onborading",
                   animationName: String.OnboardingAnimation.notifications),
        IntroScene(name: "Third",
                   mainTitle: "You are all caugth up",
                   animationName: String.OnboardingAnimation.temp)
    ]

    init(loginUseCase: LoginUseCase, actions: LoginViewModelActions) {
        self.loginUseCase = loginUseCase
        self.actions = actions
    }
}

// MARK: - LoginViewModelInput
extension LoginViewModelImpl {
    func viewDidLoad() {}

    func fetchToken(authCode: String) {
        loginUseCase.fetchToken(authCode: authCode) { result in
            switch result {
            case .success(_):
                self.finishLoginFlow()
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
}

// MARK: - Private
private extension LoginViewModelImpl {
    func finishLoginFlow() {
        actions.userLoggedIn()
    }

    func handleError(_ error: Error) {
        let errorTempName = NSLocalizedString("TempError", comment: "")
        self.error.value = errorTempName
    }
}
