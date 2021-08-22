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
        tabBarController = container.makeTabController()
    }

    func start() {
        container.configureTabController(controller: tabBarController,
                                         homeDependencies: homeDependencies(),
                                         profileDependencies: profileDependencies())
        
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
            user: user,
            startRepFlow: startRepFlow(repository:),
            openLink: container.dependencies.openLink,
            share: container.dependencies.share,
            sendEmail: container.dependencies.sendMail,
            showRecentEvents: showRecentEvents(_:),
            showStarred: showStarred(_:),
            showGists: showGists(_:),
            showSubscriptions: showSubscriptions(_:),
            showOrganizations: showOrganizations(_:),
            showEvents: showEvents(_:),
            showRepositories: showRepositories(_:),
            showFollowers: showFollowers(_:),
            showFollowing: showFollowing(_:))
        let starredSceneDIContainer = container.makeStarredSceneDIContainer(dependencies: dependency)
        let flow = starredSceneDIContainer.makeStarredFlowCoordinator(in: currentNavigationController)
        flow.start()
    }

    func showFollowers(_ user: User) {
    }

    func showFollowing(_ user: User) {
    }

    func showRepositories(_ user: User) {
    }

    func showRecentEvents(_ user: User) {
    }

    func showGists(_ user: User) {
    }

    func showSubscriptions(_ user: User) {
    }

    func showEvents(_ user: User) {
    }

    func showOrganizations(_ user: User) {
    }

    func showStarred(_ user: User) {
    }

    func startRepFlow(repository: Repository) {
        let dependency = RepSceneDIContainer.Dependencies(
            repository: repository,
            showUser: startUserFlow(user:),
            showRepository: startRepFlow(repository:),
            openLink: container.dependencies.openLink,
            share: container.dependencies.share,
            copy: copy(text:)
        )
        let repSceneDIContainer = container.makeRepSceneDIContainer(dependencies: dependency)
        let flow = repSceneDIContainer.makeRepFlowCoordinator(in: currentNavigationController)
        flow.start()
    }

    func copy(text: String) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = text
    }

    func startPullRequestFlow(pullRequest: PullRequest) {}

    func showMyOrganizationsList() {}

    func startEventFlow(event: Event) {}

    func homeDependencies() -> HomeDIContainer.Actions {
        .init()
    }

    func profileDependencies() -> ProfileDIContainer.Actions {
        .init(
            openUserProfile: startUserFlow(user:),
            openRepository: startRepFlow(repository:),
            openSettings: container.dependencies.openSettings,
            sendMail: container.dependencies.sendMail,
            openLink: container.dependencies.openLink,
            share: container.dependencies.share)
    }
}
