//
//  AppFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class AppFlowCoordinator {

    private let navigation: UINavigationController
    private let appDIContainer: AppDIContainer

    init(navigation: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigation = navigation
        self.appDIContainer = appDIContainer
    }

    func startUserFlow(user: User) {
        //todo add login logic
        let dependency = UserSceneDIContainer.Dependencies(
            user: user,
            startRepFlow: startRepFlow(repository:),
            openLink: open(link:),
            share: share(link:),
            sendEmail: sendEmail(email:)
        )
        let starredSceneDIContainer = appDIContainer.makeStarredSceneDIContainer(dependencies: dependency)
        let flow = starredSceneDIContainer.makeStarredFlowCoordinator(navigationConroller: navigation)
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
        let flow = repSceneDIContainer.makeRepFlowCoordinator(navigationController: navigation)
        flow.start()
    }

    func open(link: URL) {}
    func share(link: URL) {}
    func sendEmail(email: String) {}
}
