//
//  AppCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class AppCoordinator {

    private let window: UIWindow
    private let appDIContainer: AppDIContainer
    private var navigation: UINavigationController?

    init(in window: UIWindow, appDIContainer: AppDIContainer) {
        self.window = window
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        switch UserStorage.shared.loginState {
        case .logged:
            startMainFlow()
        case .notLogged:
            startLoginFlow()
        }
    }

    func startMainFlow() {
        let flow = appDIContainer.makeTabCoordinator(window: window)
        flow.start()
    }
    
    func startLoginFlow() {
        let dependency = LoginSceneDIContainer.Dependencies.init(userLoggedIn: startMainFlow)
        let loginDIContainer = appDIContainer.makeLoginSceneDIContainer(dependencies: dependency)
        let flow = loginDIContainer.makeLoginFlowCoordinator(in: window)
        flow.start()
    }

    func startUserFlow(user: User) {
        let dependency = UserSceneDIContainer.Dependencies(
            user: user,
            startRepFlow: startRepFlow(repository:),
            openLink: open(link:),
            share: share(link:),
            sendEmail: sendEmail(email:)
        )
        let starredSceneDIContainer = appDIContainer.makeStarredSceneDIContainer(dependencies: dependency)
        let flow = starredSceneDIContainer.makeStarredFlowCoordinator(navigationConroller: navigation!)
        flow.start()
    }

    func startRepFlow(repository: Repository) {
        let dependency = RepSceneDIContainer.Dependencies(
            repository: repository,
            startUserFlow: startUserFlow(user:),
            openLink: open(link:),
            share: share(link:)
        )
        let repSceneDIContainer = appDIContainer.makeRepSceneDIContainer(dependencies: dependency)
        let flow = repSceneDIContainer.makeRepFlowCoordinator(navigationController: navigation!)
        flow.start()
    }

    func open(link: URL) {}
    func share(link: URL) {}
    func sendEmail(email: String) {}
}
