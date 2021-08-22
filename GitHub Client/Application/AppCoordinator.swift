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
        let dependencies = MainSceneDIContainer.Dependencies(
            logout: startLoginFlow,
            openSettings: openSettings,
            sendMail: sendEmail(email:),
            openLink: open(link:),
            share: share(link:)
        )
        let flow = appDIContainer.makeTabCoordinator(window: window, dependencies: dependencies)
        flow.start()
    }

    func startLoginFlow() {
        let dependency = LoginSceneDIContainer.Dependencies.init(
            dataTransferService: appDIContainer.apiDataTransferService,
            userLoggedIn: startMainFlow)
        let loginDIContainer = appDIContainer.makeLoginSceneDIContainer(dependencies: dependency)
        let flow = loginDIContainer.makeLoginFlowCoordinator(in: window)
        flow.start()
    }

    func openSettings(in navigation: UINavigationController) {
        let dependency = appDIContainer.makeSettingsDependencies()
        let flow = SettingsCoordinator(in: navigation, with: dependency)
        flow.start()
    }

    func open(link: URL) {}
    func share(link: URL) {}
    func sendEmail(email: String) {}
}
