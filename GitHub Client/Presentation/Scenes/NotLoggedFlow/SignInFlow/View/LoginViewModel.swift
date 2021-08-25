//
//  LoginViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

struct LoginViewModelActions {
    let userLoggedIn: () -> Void
    let openSettings: () -> Void
}

protocol LoginViewModelInput {
    func viewDidLoad()
    func openSettings()
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
        IntroScene(name: "Notificatons",
                   mainTitle: "Watch your notifications",
                   animationName: String.OnboardingAnimation.favorites),
        IntroScene(name: "Comments",
                   mainTitle: "Leave comments in discussions",
                   animationName: String.OnboardingAnimation.notifications),
        IntroScene(name: "Subscribe",
                   mainTitle: "Subscribe to projects activity",
                   animationName: String.OnboardingAnimation.favorites)
    ]

    init(loginUseCase: LoginUseCase, actions: LoginViewModelActions) {
        self.loginUseCase = loginUseCase
        self.actions = actions
    }
}

// MARK: - LoginViewModelInput
extension LoginViewModelImpl {
    func viewDidLoad() {}

    func openSettings() {
        actions.openSettings()
    }

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
