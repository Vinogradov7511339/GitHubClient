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

    lazy var favoritesStorage: FavoritesStorage = {
        let favoritesStorage = FavoritesStorageImpl()
        return favoritesStorage
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

    // MARK: - Factories

    var userFactory: UserFactory {
        UsersListFactoryImpl(dataTransferService: dataTransferService)
    }

    // MARK: - Coordinators

    func notLoggedCoordinator(in window: UIWindow,
                            actions: AppCoordinatorActions) -> NotLoggedFlowCoordinator {

        let container = NotLoggedSceneDIContainer(loginDependencies(actions))
        return NotLoggedFlowCoordinator(in: window, dependencies: container)
    }

    func mainCoordinator(in window: UIWindow,
                         actions: AppCoordinatorActions) -> MainCoordinator {

        let container = MainSceneDIContainer(mainDependencies(actions))
        return MainCoordinator(in: window, dependencies: container)
    }

    func settingsCoordinator(in nav: UINavigationController,
                             actions: AppCoordinatorActions) -> SettingsCoordinator {

        let container = SettingsDIContainer(settingsDependencies(actions))
        return SettingsCoordinator(with: container, in: nav)
    }

    func repositoryCoordinator(in nav: UINavigationController,
                               actions: AppCoordinatorActions,
                               repository: URL) -> RepFlowCoordinator {

        let container = RepositoryDIContainer(repositoryDependencies(actions, repository: repository))
        return RepFlowCoordinator(in: nav, with: container)
    }

    func userCoordinator(in nav: UINavigationController,
                         actions: AppCoordinatorActions,
                         userUrl: URL) -> UserFlowCoordinator {

        let container = UserProfileDIContainer(dependencies: userDependencies(actions, userUrl: userUrl))
        return UserFlowCoordinator(with: container, in: nav)
    }

    func issueCoordinator(in nav: UINavigationController,
                          actions: AppCoordinatorActions,
                          issue: Issue) -> IssueCoordinator {

        let container = IssueDIContainer(issueDependencies(actions, issue: issue))
        return IssueCoordinator(with: container, in: nav)
    }

    func pullRequestCoordinator(in nav: UINavigationController,
                                actions: AppCoordinatorActions,
                                pullRequest: PullRequest) -> PullRequestCoordinator {

        let container = PullRequestDIContainer(pullRequestDependencies(actions, pullRequest: pullRequest))
        return PullRequestCoordinator(with: container, in: nav)
    }

    func releaseCoordinator(in nav: UINavigationController,
                            actions: AppCoordinatorActions,
                            release: Release) -> ReleaseFlowCoordinator {
        let container = ReleaseDIContainer(releaseDependencies(actions, release: release))
        return ReleaseFlowCoordinator(with: container, in: nav)
    }

    func commitsCoordinator(in nav: UINavigationController,
                            actions: AppCoordinatorActions,
                            commitsUrl: URL) -> CommitsCoordinator {
        let container = CommitsDIContainer(commitsDependencies(actions, commitsUrl: commitsUrl))
        return CommitsCoordinator(with: container, in: nav)
    }

    func commitCoordinator(in nav: UINavigationController,
                           actions: AppCoordinatorActions,
                           commitsUrl: URL) -> CommitCoordinator {
        let container = CommitDIContainer(commitDependencies(commitsUrl))
        return CommitCoordinator(with: container, in: nav)
    }
}

// MARK: - Dependencies
private extension AppDIContainer {
    func loginDependencies(_ actions: AppCoordinatorActions) -> NotLoggedSceneDIContainer.Dependencies {
        .init(dataTransferService: dataTransferService,
              searchFilterStorage: searchFilterStorage,
              exploreSettingsStorage: exploreSettingsStorage,
              userLoggedIn: actions.login,
              openSettings: actions.openSettings(in:),
              openRepository: actions.openRepository(_:in:),
              openUser: actions.openUser(_:in:),
              openIssue: actions.openIssue(_:in:),
              openPullRequest: actions.openPullRequest(_:in:))
    }

    func mainDependencies(_ actions: AppCoordinatorActions) -> MainSceneDIContainer.Dependencies {
        .init(dataTransferService: dataTransferService,
              favoritesStorage: favoritesStorage,
              profileStorage: profileStorage,
              searchFilterStorage: searchFilterStorage,
              exploreSettingsStorage: exploreSettingsStorage,
              logout: actions.logout,
              openSettings: actions.openSettings(in:),
              openRepository: actions.openRepository(_:in:),
              openUser: actions.openUser(_:in:),
              openIssue: actions.openIssue(_:in:),
              openPullRequest: actions.openPullRequest(_:in:),
              sendMail: actions.send(email:),
              openLink: actions.open(link:),
              share: actions.share(link:))
    }

    func settingsDependencies(_ actions: AppCoordinatorActions) -> SettingsDIContainer.Dependencies {
        .init(logout: actions.logout)
    }

    func repositoryDependencies(_ actions: AppCoordinatorActions,
                                repository: URL) -> RepositoryDIContainer.Dependencies {
        .init(dataTransferService: dataTransferService,
              issueFilterStorage: issueFilterStorage,
              url: repository,
              showUser: actions.openUser(_:in:),
              showIssue: actions.openIssue(_:in:),
              showPullRequest: actions.openPullRequest(_:in:),
              showRelease: actions.openRelease(_:in:),
              showCommits: actions.showCommits(_:in:),
              showRepository: actions.openRepository(_:in:),
              openLink: actions.open(link:),
              share: actions.share(link:),
              copy: actions.copy(text:))
    }

    func userDependencies(_ actions: AppCoordinatorActions,
                          userUrl: URL) -> UserProfileDIContainer.Dependencies {
        .init(dataTransferService: dataTransferService,
              userUrl: userUrl,
              startRepFlow: actions.openRepository(_:in:),
              openLink: actions.open(link:),
              share: actions.share(link:),
              sendEmail: actions.send(email:))
    }

    func issueDependencies(_ actions: AppCoordinatorActions,
                           issue: Issue) -> IssueDIContainer.Dependencies {
        .init(dataTransferService: dataTransferService,
              filterStorage: issueFilterStorage,
              issue: issue)
    }

    func pullRequestDependencies(_ actions: AppCoordinatorActions,
                                 pullRequest: PullRequest) -> PullRequestDIContainer.Dependencies {
        .init(dataTransferService: dataTransferService,
              pullRequest: pullRequest,
              showCommits: actions.showCommits(_:in:))
    }

    func releaseDependencies(_ actions: AppCoordinatorActions,
                             release: Release) -> ReleaseDIContainer.Dependencies {
        .init(dataTransferService: dataTransferService,
              release: release)
    }

    func commitsDependencies(_ actions: AppCoordinatorActions,
                             commitsUrl: URL) -> CommitsDIContainer.Dependencies {
        .init(dataTransferService: dataTransferService,
                      issueFilterStorage: issueFilterStorage,
                      commitsUrl: commitsUrl,
                      showCommit: actions.showCommit(_:in:))
    }

    func commitDependencies(_ commitUrl: URL) -> CommitDIContainer.Dependencies {
        .init(dataTransferService: dataTransferService,
              issueFilterStorage: issueFilterStorage,
              commitUrl: commitUrl)
    }
}
