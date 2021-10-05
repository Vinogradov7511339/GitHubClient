//
//  AppCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

protocol AppCoordinatorDependencies {
    func notLoggedCoordinator(
        in window: UIWindow,
        actions: AppCoordinatorActions
    ) -> NotLoggedFlowCoordinator

    func mainCoordinator(
        in window: UIWindow,
        actions: AppCoordinatorActions
    ) -> MainCoordinator

    func settingsCoordinator(
        in nav: UINavigationController,
        actions: AppCoordinatorActions
    ) -> SettingsCoordinator

    func repositoryCoordinator(
        in nav: UINavigationController,
        actions: AppCoordinatorActions,
        repository: URL
    ) -> RepFlowCoordinator

    func userCoordinator(
        in nav: UINavigationController,
        actions: AppCoordinatorActions,
        userUrl: URL
    ) -> UserFlowCoordinator

    func issueCoordinator(
        in nav: UINavigationController,
        actions: AppCoordinatorActions,
        issue: URL
    ) -> IssueCoordinator

    func pullRequestCoordinator(
        in nav: UINavigationController,
        actions: AppCoordinatorActions,
        pullRequest: PullRequest
    ) -> PullRequestCoordinator

    func releaseCoordinator(
        in nav: UINavigationController,
        actions: AppCoordinatorActions,
        release: Release
    ) -> ReleaseFlowCoordinator

    func commitsCoordinator(
        in nav: UINavigationController,
        actions: AppCoordinatorActions,
        commitsUrl: URL
    ) -> CommitsCoordinator

    func commitCoordinator(
        in nav: UINavigationController,
        actions: AppCoordinatorActions,
        commitUrl: URL
    ) -> CommitCoordinator
}

protocol AppCoordinatorActions {
    func login()
    func logout()

    func send(email: String)
    func open(link: URL?)
    func share(link: URL?)
    func copy(text: String)

    func showSettings(in nav: UINavigationController)
    func showRepository(_ repositoryURL: URL, in nav: UINavigationController)
    func showProfile(_ profileURL: URL, in nav: UINavigationController)
    func showIssue(_ issueURL: URL, in nav: UINavigationController)
    func showPull(_ pullRequest: PullRequest, in nav: UINavigationController)
    func showRelease(_ release: Release, in nav: UINavigationController)
    func showCommits(_ commitsURL: URL, in nav: UINavigationController)
    func showCommit(_ commitURL: URL, in nav: UINavigationController)
}

final class AppCoordinator {

    // MARK: - Private variables

    private let window: UIWindow
    private let dependencies: AppCoordinatorDependencies

    // MARK: - Lifecycle

    init(with dependencies: AppCoordinatorDependencies, in window: UIWindow) {
        self.window = window
        self.dependencies = dependencies
    }

    func start() {
        switch UserStorage.shared.loginState {
        case .logged:
            startMainFlow()
        case .notLogged:
            startLoginFlow()
        }
    }
}

// MARK: - Main flows
private extension AppCoordinator {
    func startMainFlow() {
        let flow = dependencies.mainCoordinator(in: window, actions: self)
        flow.start()
    }

    func startLoginFlow() {
        UserStorage.shared.clearStorage()
        let flow = dependencies.notLoggedCoordinator(in: window, actions: self)
        flow.start()

    }
}

// MARK: - LoginFlowCoordinatorActions
extension AppCoordinator: AppCoordinatorActions {
    func login() {
        startMainFlow()
    }

    func logout() {
        startLoginFlow()
    }

    func send(email: String) {
        guard let link = URL(string: "mailto:\(email)") else { return }
        UIApplication.shared.open(link, options: [:], completionHandler: nil)
    }

    func open(link: URL?) {
        guard let link = link else { return }
        UIApplication.shared.open(link, options: [:], completionHandler: nil)
    }

    func share(link: URL?) {
        guard let link = link else { return }
        let share = UIActivityViewController(activityItems: [link], applicationActivities: nil)
        window.rootViewController?.present(share, animated: true, completion: nil)
    }

    func copy(text: String) {
        UIPasteboard.general.string = text
    }

    func showSettings(in nav: UINavigationController) {
        let coordinator = dependencies.settingsCoordinator(in: nav, actions: self)
        coordinator.start()
    }

    func showRepository(_ repositoryURL: URL, in nav: UINavigationController) {
        let coordinator = dependencies.repositoryCoordinator(
            in: nav, actions: self,
            repository: repositoryURL
        )
        coordinator.start()
    }

    func showProfile(_ profileURL: URL, in nav: UINavigationController) {
        let coordinator = dependencies.userCoordinator(in: nav, actions: self, userUrl: profileURL)
        coordinator.start()
    }

    func showIssue(_ issueURL: URL, in nav: UINavigationController) {
        let coordinator = dependencies.issueCoordinator(in: nav, actions: self, issue: issueURL)
        coordinator.start()
    }

    func showPull(_ pullRequest: PullRequest, in nav: UINavigationController) {
        let coordinator = dependencies.pullRequestCoordinator(
            in: nav,
            actions: self,
            pullRequest: pullRequest
        )
        coordinator.start()
    }

    func showRelease(_ release: Release, in nav: UINavigationController) {
        let coordinator = dependencies.releaseCoordinator(in: nav, actions: self, release: release)
        coordinator.start()
    }

    func showCommits(_ commitsURL: URL, in nav: UINavigationController) {
        let coordinator = dependencies.commitsCoordinator(in: nav, actions: self, commitsUrl: commitsURL)
        coordinator.start()
    }

    func showCommit(_ commitURL: URL, in nav: UINavigationController) {
        let coordinator = dependencies.commitCoordinator(in: nav, actions: self, commitUrl: commitURL)
        coordinator.start()
    }
}
