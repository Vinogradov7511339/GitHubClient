//
//  TabCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

class MainCoordinator: NSObject {

    private let container: MainSceneDIContainer
    private let tabBarController: UITabBarController
    private let window: UIWindow

    private var currentNavigationController: UINavigationController {
        if let navigation = tabBarController.selectedViewController as? UINavigationController {
            return navigation
        } else {
            fatalError()
        }
    }

    init(in window: UIWindow, mainSceneDIContainer: MainSceneDIContainer) {
        self.window = window
        self.container = mainSceneDIContainer
        self.tabBarController = container.makeTabController()
    }

    func start() {
        container.openRepository = startRepFlow(repository:)
        container.openUserProfile = startUserFlow(user:)
        container.openIssue = startIssueFlow(issue:)
        
        if let previousController = window.rootViewController {
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft) {
                self.window.subviews.forEach { $0.removeFromSuperview() }
                self.window.rootViewController = self.tabBarController
            } completion: { _ in
                previousController.dismiss(animated: false, completion: {
                    previousController.view.removeFromSuperview()
                })
            }
        } else {
            window.rootViewController = tabBarController
        }
    }

    func startUserFlow(user: User) {
        let dependency = UserSceneDIContainer.Dependencies(
            apiDataTransferService: container.dependencies.apiDataTransferService,
            user: user,
            startRepFlow: startRepFlow(repository:),
            openLink: container.dependencies.openLink,
            share: container.dependencies.share,
            sendEmail: container.dependencies.sendMail
        )
        let starredSceneDIContainer = container.makeStarredSceneDIContainer(dependencies: dependency)
        let flow = starredSceneDIContainer.makeStarredFlowCoordinator(in: currentNavigationController)
        flow.start()
    }

    func startRepFlow(repository: Repository) {
        let dependency = RepSceneDIContainer.Dependencies(
            repository: repository,
            startUserFlow: startUserFlow(user:),
            openLink: container.dependencies.openLink,
            share: container.dependencies.share
        )
        let repSceneDIContainer = container.makeRepSceneDIContainer(dependencies: dependency)
        let flow = repSceneDIContainer.makeRepFlowCoordinator(in: currentNavigationController)
        flow.start()
    }

    func startIssueFlow(issue: Issue) {
        let actions = IssueActions()
        let viewController = container.makeIssueController(issue: issue, actions: actions)
        currentNavigationController.pushViewController(viewController, animated: true)
    }
}
