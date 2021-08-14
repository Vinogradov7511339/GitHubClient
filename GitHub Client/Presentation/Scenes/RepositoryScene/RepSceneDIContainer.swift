//
//  RepSceneDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

class RepSceneDIContainer {

    struct Dependencies {
        let repository: Repository
        var startUserFlow: (User) -> Void
        var startRepFlow: (Repository) -> Void
        var openLink: (URL) -> Void
        var share: (URL) -> Void
    }

    private let dependencies: Dependencies
    private let factory: ExtendedRepositoryFactory
    private let itemsListFactory: ItemsListFactory
    private let issuesFactory: IssuesFactory
    private let usersFactory: UsersListFactory
    private let repositoriesFactory: RepositoriesFactory
    private let commitsFactory: CommitsFactory
    private let issueFactory: IssueFactory

    init(parentContainer: MainSceneDIContainer, dependencies: Dependencies) {
        self.dependencies = dependencies
        factory = ExtendedRepositoryFactoryImpl(repository: dependencies.repository,
                                                favoriteStorage: parentContainer.favoritesStorage,
                                                dataTransferService: parentContainer.apiDataTransferService)
        itemsListFactory = ItemsListFactoryImpl(dataTransferService: parentContainer.apiDataTransferService)
        issuesFactory = IssuesFactoryImpl(dataTransferService: parentContainer.apiDataTransferService)
        usersFactory = UsersListFactoryImpl(dataTransferService: parentContainer.apiDataTransferService)
        repositoriesFactory = RepositoriesFactoryImpl(dataTransferService: parentContainer.apiDataTransferService)
        commitsFactory = CommitsFactoryImpl(dataTransferService: parentContainer.apiDataTransferService)
        issueFactory = IssueFactoryImpl(dataTransferService: parentContainer.apiDataTransferService)
    }

    func makeRepFlowCoordinator(in navigationController: UINavigationController) -> RepFlowCoordinator {
        return .init(navigationController: navigationController, dependencies: self)
    }
}

extension RepSceneDIContainer: RepFlowCoordinatorDependencies {
    func startUserFlow(with user: User) {
        dependencies.startUserFlow(user)
    }

    func startRepFlow(with repository: Repository) {
        dependencies.startRepFlow(repository)
    }

    func openLink(url: URL) {
        dependencies.openLink(url)
    }

    func share(url: URL) {
        dependencies.share(url)
    }

    // MARK: - Rep flow

    func makeRepViewController(actions: RepActions) -> RepositoryDetailsVC {
        factory.makeExtendedRepositoryViewController(actions: actions)
    }

    func makeStargazersViewController(for repository: Repository, actions: UsersListActions) -> UsersListViewController {
        usersFactory.createStargazersViewController(for: repository, actions: actions)
    }

    func makeForksViewController(for repository: Repository, actions: RepositoriesActions) -> RepositoriesViewController {
        repositoriesFactory.createForksViewController(for: repository, actions: actions)
    }

    func makeIssuesViewController(for repository: Repository, actions: IssuesActions) -> IssuesViewController {
        issuesFactory.makeIssuesViewController(repository: repository, actions: actions)
    }

    func makeIssueViewController(for issue: Issue, actions: IssueActions) -> IssueDetailsViewController {
        issueFactory.makeIssueViewController(issue: issue, actions: actions)
    }

    func makePullRequestsViewController(for repository: Repository, actions: ItemsListActions<PullRequest>) -> ItemsListViewController<PullRequest> {
        itemsListFactory.makePullRequestsViewController(repository: repository, actions: actions)
    }

    func makeReleasesViewController(for repository: Repository, actions: ItemsListActions<Release>) -> ItemsListViewController<Release> {
        itemsListFactory.makeReleasesViewController(repository: repository, actions: actions)
    }

    func makeCommitsViewController(for repository: Repository, actions: CommitsActions) -> CommitsViewController {
        commitsFactory.makeCommitsViewController(repository: repository, actions: actions)
    }
}
