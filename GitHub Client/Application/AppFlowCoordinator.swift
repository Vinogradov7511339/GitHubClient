//
//  AppFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class AppFlowCoordinator {

    private let window: UIWindow
    private let appDIContainer: AppDIContainer
    private var navigation: UINavigationController?

    init(in window: UIWindow, appDIContainer: AppDIContainer) {
        self.window = window
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        if appDIContainer.isUserLogged() {
//            startAppFlow()
        } else {
            startLoginFlow()
        }
    }
    
    func startAppFlow(authenticatedUser: AuthenticatedUser) {
        let tabBarController = TabBarController()
        if let previousController = window.rootViewController {
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft) {
                self.window.subviews.forEach { $0.removeFromSuperview() }
                self.window.rootViewController = tabBarController
            } completion: { _ in
                previousController.dismiss(animated: false, completion: {
                    previousController.view.removeFromSuperview()
                })
            }
        } else {
            window.rootViewController = tabBarController
        }
    }
    
    func startLoginFlow() {
        let dependency = LoginSceneDIContainer.Dependencies.init(userLoggedIn: startAppFlow(authenticatedUser:))
        let loginDIContainer = appDIContainer.makeLoginSceneDIContainer(dependencies: dependency)
        let flow = loginDIContainer.makeLoginFlowCoordinator(in: window)
        flow.start()
        let loginController = LoginViewController()
        window.rootViewController = loginController
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
