//
//  AppCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

protocol AppCoordinatorDependencies {
    var userFactory: UserFactory { get }

    func notLoggedCoordinator(in window: UIWindow, actions: AppCoordinatorActions) -> NotLoggedFlowCoordinator
    func mainCoordinator(in window: UIWindow, actions: AppCoordinatorActions) -> MainCoordinator

    func settingsCoordinator(in nav: UINavigationController,
                             actions: AppCoordinatorActions) -> SettingsCoordinator

    func repositoryCoordinator(in nav: UINavigationController,
                               actions: AppCoordinatorActions,
                               repository: Repository) -> RepFlowCoordinator

    func userCoordinator(in nav: UINavigationController,
                         actions: AppCoordinatorActions,
                         userUrl: URL) -> UserFlowCoordinator

    func issueCoordinator(in nav: UINavigationController,
                          actions: AppCoordinatorActions,
                          issue: Issue) -> IssueCoordinator

    func pullRequestCoordinator(in nav: UINavigationController,
                                actions: AppCoordinatorActions,
                                pullRequest: PullRequest) -> PullRequestCoordinator

    func releaseCoordinator(in nav: UINavigationController,
                            actions: AppCoordinatorActions,
                            release: Release) -> ReleaseFlowCoordinator

    func commitsCoordinator(in nav: UINavigationController,
                            actions: AppCoordinatorActions,
                            commitsUrl: URL) -> CommitsCoordinator

    func commitCoordinator(in nav: UINavigationController,
                           actions: AppCoordinatorActions,
                           commitsUrl: URL) -> CommitCoordinator
}

protocol AppCoordinatorActions {
    func login()
    func logout()

    func send(email: String)
    func open(link: URL?)
    func share(link: URL?)
    func copy(text: String)

    func openSettings(in nav: UINavigationController)
    func openRepository(_ repository: Repository, in nav: UINavigationController)
    func openUser(_ url: URL, in nav: UINavigationController)
    func openIssue(_ issue: Issue, in nav: UINavigationController)
    func openPullRequest(_ pullRequest: PullRequest, in nav: UINavigationController)
    func openRelease(_ release: Release, in nav: UINavigationController)

    func showCommits(_ url: URL, in nav: UINavigationController)
    func showCommit(_ url: URL, in nav: UINavigationController)

    // MARK: - Remove

    func openUserRecentEvents(_ user: User, in nav: UINavigationController)
    func openUserStarred(_ user: User, in nav: UINavigationController)
    func openUserGists(_ user: User, in nav: UINavigationController)
    func openUserSubscriptions(_ user: User, in nav: UINavigationController)
    func openUserEvents(_ user: User, in nav: UINavigationController)
    func openUserRepositories(_ user: User, in nav: UINavigationController)
    func openUserFollowers(_ user: User, in nav: UINavigationController)
    func openUserFollowing(_ user: User, in nav: UINavigationController)
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

    // NARK: - Flows

    func openSettings(in nav: UINavigationController) {
        let coordinator = dependencies.settingsCoordinator(in: nav, actions: self)
        coordinator.start()
    }

    func openRepository(_ repository: Repository, in nav: UINavigationController) {
        let coordinator = dependencies.repositoryCoordinator(in: nav, actions: self, repository: repository)
        coordinator.start()
    }

    func openUser(_ url: URL, in nav: UINavigationController) {
        let coordinator = dependencies.userCoordinator(in: nav, actions: self, userUrl: url)
        coordinator.start()
    }

    func openIssue(_ issue: Issue, in nav: UINavigationController) {
        let coordinator = dependencies.issueCoordinator(in: nav, actions: self, issue: issue)
        coordinator.start()
    }

    func openPullRequest(_ pullRequest: PullRequest, in nav: UINavigationController) {
        let coordinator = dependencies.pullRequestCoordinator(in: nav,
                                                              actions: self,
                                                              pullRequest: pullRequest)
        coordinator.start()
    }

    func openRelease(_ release: Release, in nav: UINavigationController) {
        let coordinator = dependencies.releaseCoordinator(in: nav, actions: self, release: release)
        coordinator.start()
    }

    func showCommits(_ url: URL, in nav: UINavigationController) {
        let coordinator = dependencies.commitsCoordinator(in: nav, actions: self, commitsUrl: url)
        coordinator.start()
    }

    func showCommit(_ url: URL, in nav: UINavigationController) {
        let coordinator = dependencies.commitCoordinator(in: nav, actions: self, commitsUrl: url)
        coordinator.start()
    }

    // MARK: - Screens

    func openUserRecentEvents(_ user: User, in nav: UINavigationController) {
        let viewController = dependencies.userFactory.recentEventsViewController(user: user)
        nav.pushViewController(viewController, animated: true)
    }

    func openUserStarred(_ user: User, in nav: UINavigationController) {
        let actions = RepositoriesActions(showRepository: openRepository(in: nav))
        let viewController = dependencies.userFactory.starredViewController(user: user, actions)
        nav.pushViewController(viewController, animated: true)
    }

    func openUserGists(_ user: User, in nav: UINavigationController) {
        let viewController = dependencies.userFactory.gistsViewController(user: user)
        nav.pushViewController(viewController, animated: true)
    }

    func openUserSubscriptions(_ user: User, in nav: UINavigationController) {
        let viewController = dependencies.userFactory.subscriptionsViewController(user: user)
        nav.pushViewController(viewController, animated: true)
    }

    func openUserEvents(_ user: User, in nav: UINavigationController) {
        let viewController = dependencies.userFactory.eventsViewController(user: user)
        nav.pushViewController(viewController, animated: true)
    }

    func openUserRepositories(_ user: User, in nav: UINavigationController) {
        let actions = RepositoriesActions(showRepository: openRepository(in: nav))
        let viewControllers = dependencies.userFactory.repositoriesViewController(user: user, actions)
        nav.pushViewController(viewControllers, animated: true)
    }

    func openUserFollowers(_ user: User, in nav: UINavigationController) {
//        let actions = UsersListActions(showUser: openUser(in: nav))
//        let viewControllers = dependencies.userFactory.followersViewController(user: user, actions)
//        nav.pushViewController(viewControllers, animated: true)
    }

    func openUserFollowing(_ user: User, in nav: UINavigationController) {
//        let actions = UsersListActions(showUser: openUser(in: nav))
//        let viewControllers = dependencies.userFactory.followingViewController(user: user, actions)
//        nav.pushViewController(viewControllers, animated: true)
    }
}

// MARK: - Currying functions
private extension AppCoordinator {
    func openRepository(in nav: UINavigationController) -> (Repository) -> Void {
        return { repository in self.openRepository(repository, in: nav)}
    }

    func openUser(in nav: UINavigationController) -> (URL) -> Void {
        return { user in self.openUser(user, in: nav) }
    }
}
