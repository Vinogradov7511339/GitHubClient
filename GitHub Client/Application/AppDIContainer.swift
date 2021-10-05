//
//  AppDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class AppDIContainer {

    static let shared = AppDIContainer()

    // MARK: - Private variables

    private let appConfiguration = AppConfiguration()

    // MARK: - Services

    lazy var dataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!)
        let networkService = NetworkServiceImpl(config: config)
        return DataTransferServiceImpl(with: networkService)
    }()

    lazy var searchFilterStorage: SearchFilterStorage = {
        let storage = SearchFilterStorageImpl()
        return storage
    }()

    lazy var issueFilterStorage: IssueFilterStorage = {
        let storage = IssueFilterStorageImpl()
        return storage
    }()

    lazy var profileStorage: ProfileLocalStorage = {
        let profileStorage = ProfileLocalStorageImpl()
        return profileStorage
    }()

    lazy var exploreSettingsStorage: ExploreWidgetsRequestStorage = {
        let exploreSettingsStorage = ExploreWidgetsRequestStorageImpl()
        return exploreSettingsStorage
    }()
}

// MARK: - AppCoordinatorDependencies
extension AppDIContainer: AppCoordinatorDependencies {
    func notLoggedCoordinator(
        in window: UIWindow,
        actions: AppCoordinatorActions
    ) -> NotLoggedFlowCoordinator {
        let dependencies = loginDependencies(actions)
        let container = NotLoggedSceneDIContainer(dependencies)
        return NotLoggedFlowCoordinator(in: window, dependencies: container)
    }

    func mainCoordinator(
        in window: UIWindow,
        actions: AppCoordinatorActions
    ) -> MainCoordinator {
        let dependencies = mainDependencies(actions)
        let container = MainSceneDIContainer(dependencies)
        return MainCoordinator(in: window, dependencies: container)
    }

    func settingsCoordinator(
        in nav: UINavigationController,
        actions: AppCoordinatorActions
    ) -> SettingsCoordinator {
        let dependencies = settingsDependencies(actions)
        let container = SettingsDIContainer(dependencies)
        return SettingsCoordinator(with: container, in: nav)
    }

    func repositoryCoordinator(
        in nav: UINavigationController,
        actions: AppCoordinatorActions,
        repository: URL
    ) -> RepFlowCoordinator {
        let dependencies = repositoryDependencies(actions, repository: repository)
        let container = RepositoryDIContainer(dependencies)
        return RepFlowCoordinator(in: nav, with: container)
    }

    func userCoordinator(
        in nav: UINavigationController,
        actions: AppCoordinatorActions,
        userUrl: URL
    ) -> UserFlowCoordinator {
        let dependencies = userDependencies(actions, userUrl: userUrl)
        let container = UserProfileDIContainer(dependencies: dependencies)
        return UserFlowCoordinator(with: container, in: nav)
    }

    func issueCoordinator(
        in nav: UINavigationController,
        actions: AppCoordinatorActions,
        issue: URL
    ) -> IssueCoordinator {
        let dependencies = issueDependencies(actions, issue: issue)
        let container = IssueDIContainer(dependencies)
        return IssueCoordinator(with: container, in: nav)
    }

    func pullRequestCoordinator(
        in nav: UINavigationController,
        actions: AppCoordinatorActions,
        pullRequest: PullRequest
    ) -> PullRequestCoordinator {
        let dependencies = pullRequestDependencies(actions, pullRequest: pullRequest)
        let container = PullRequestDIContainer(dependencies)
        return PullRequestCoordinator(with: container, in: nav)
    }

    func releaseCoordinator(
        in nav: UINavigationController,
        actions: AppCoordinatorActions,
        release: Release
    ) -> ReleaseFlowCoordinator {
        let dependencies = releaseDependencies(actions, release: release)
        let container = ReleaseDIContainer(dependencies)
        return ReleaseFlowCoordinator(with: container, in: nav)
    }

    func commitsCoordinator(
        in nav: UINavigationController,
        actions: AppCoordinatorActions,
        commitsUrl: URL
    ) -> CommitsCoordinator {
        let dependencies = commitsDependencies(actions, commitsUrl: commitsUrl)
        let container = CommitsDIContainer(dependencies)
        return CommitsCoordinator(with: container, in: nav)
    }

    func commitCoordinator(
        in nav: UINavigationController,
        actions: AppCoordinatorActions,
        commitUrl: URL
    ) -> CommitCoordinator {
        let dependencies = commitDependencies(commitUrl)
        let container = CommitDIContainer(dependencies)
        return CommitCoordinator(with: container, in: nav)
    }
}

// MARK: - Dependencies
private extension AppDIContainer {
    func loginDependencies(_ actions: AppCoordinatorActions) -> NotLoggedSceneDIContainer.Dependencies {
        .init(
            dataTransferService: dataTransferService,
            searchFilterStorage: searchFilterStorage,
            exploreSettingsStorage: exploreSettingsStorage,
            userLoggedIn: actions.login,
            openSettings: actions.showSettings(in:),
            openRepository: actions.showRepository(_:in:),
            openUser: actions.showProfile(_:in:),
            openIssue: actions.showIssue(_:in:),
            openPullRequest: actions.showPull(_:in:)
        )
    }

    func mainDependencies(_ actions: AppCoordinatorActions) -> MainSceneDIContainer.Dependencies {
        .init(
            dataTransferService: dataTransferService,
            profileStorage: profileStorage,
            searchFilterStorage: searchFilterStorage,
            exploreSettingsStorage: exploreSettingsStorage,
            issueFilterStorage: issueFilterStorage,
            logout: actions.logout,
            openSettings: actions.showSettings(in:),
            openRepository: actions.showRepository(_:in:),
            openUser: actions.showProfile(_:in:),
            openIssue: actions.showIssue(_:in:),
            openPullRequest: actions.showPull(_:in:),
            sendMail: actions.send(email:),
            openLink: actions.open(link:),
            share: actions.share(link:)
        )
    }

    func settingsDependencies(_ actions: AppCoordinatorActions) -> SettingsDIContainer.Dependencies {
        .init(logout: actions.logout)
    }

    func repositoryDependencies(
        _ actions: AppCoordinatorActions,
        repository: URL
    ) -> RepositoryDIContainer.Dependencies {
        .init(
            dataTransferService: dataTransferService,
            issueFilterStorage: issueFilterStorage,
            url: repository,
            showUser: actions.showProfile(_:in:),
            showIssue: actions.showIssue(_:in:),
            showPullRequest: actions.showPull(_:in:),
            showRelease: actions.showRelease(_:in:),
            showCommits: actions.showCommits(_:in:),
            showRepository: actions.showRepository(_:in:),
            openLink: actions.open(link:),
            share: actions.share(link:),
            copy: actions.copy(text:)
        )
    }

    func userDependencies(
        _ actions: AppCoordinatorActions,
        userUrl: URL
    ) -> UserProfileDIContainer.Dependencies {
        .init(
            dataTransferService: dataTransferService,
            userUrl: userUrl,
            startRepFlow: actions.showRepository(_:in:),
            showUser: actions.showProfile(_:in:),
            showRepository: actions.showRepository(_:in:),
            openLink: actions.open(link:),
            share: actions.share(link:),
            sendEmail: actions.send(email:)
        )
    }

    func issueDependencies(
        _ actions: AppCoordinatorActions,
        issue: URL
    ) -> IssueDIContainer.Dependencies {
        .init(
            dataTransferService: dataTransferService,
            filterStorage: issueFilterStorage,
            issue: issue
        )
    }

    func pullRequestDependencies(
        _ actions: AppCoordinatorActions,
        pullRequest: PullRequest
    ) -> PullRequestDIContainer.Dependencies {
        .init(
            dataTransferService: dataTransferService,
            pullRequest: pullRequest,
            showCommits: actions.showCommits(_:in:)
        )
    }

    func releaseDependencies(
        _ actions: AppCoordinatorActions,
        release: Release
    ) -> ReleaseDIContainer.Dependencies {
        .init(
            dataTransferService: dataTransferService,
            release: release
        )
    }

    func commitsDependencies(
        _ actions: AppCoordinatorActions,
        commitsUrl: URL
    ) -> CommitsDIContainer.Dependencies {
        .init(
            dataTransferService: dataTransferService,
            issueFilterStorage: issueFilterStorage,
            commitsUrl: commitsUrl,
            showCommit: actions.showCommit(_:in:)
        )
    }

    func commitDependencies(_ commitUrl: URL) -> CommitDIContainer.Dependencies {
        .init(
            dataTransferService: dataTransferService,
            issueFilterStorage: issueFilterStorage,
            commitUrl: commitUrl
        )
    }
}
