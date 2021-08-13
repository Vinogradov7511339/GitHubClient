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

    init(parentContainer: MainSceneDIContainer, dependencies: Dependencies) {
        self.dependencies = dependencies
        factory = ExtendedRepositoryFactoryImpl(repository: dependencies.repository,
                                                favoriteStorage: parentContainer.favoritesStorage)
        itemsListFactory = ItemsListFactoryImpl(dataTransferService: parentContainer.apiDataTransferService)
        issuesFactory = IssuesFactoryImpl(dataTransferService: parentContainer.apiDataTransferService)
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

    func makeRepViewController(actions: RepActions) -> RepViewController {
        factory.makeExtendedRepositoryViewController(actions: actions)
    }

    func makeStargazersViewController(for repository: Repository, actions: ItemsListActions<User>) -> ItemsListViewController<User> {
        itemsListFactory.makeStargazersViewController(repository: repository, actions: actions)
    }

    func makeForksViewController(for repository: Repository, actions: ItemsListActions<Repository>) -> ItemsListViewController<Repository> {
        itemsListFactory.makeForksViewController(repository: repository, actions: actions)
    }

    func makeIssuesViewController(for repository: Repository, actions: IssuesActions) -> IssuesViewController {
        issuesFactory.makeIssuesViewController(repository: repository, actions: actions)
    }

    func makePullRequestsViewController(for repository: Repository, actions: ItemsListActions<PullRequest>) -> ItemsListViewController<PullRequest> {
        itemsListFactory.makePullRequestsViewController(repository: repository, actions: actions)
    }

    func makeReleasesViewController(for repository: Repository, actions: ItemsListActions<Release>) -> ItemsListViewController<Release> {
        itemsListFactory.makeReleasesViewController(repository: repository, actions: actions)
    }

    func makeCommitsViewController(for repository: Repository, actions: ItemsListActions<Commit>) -> ItemsListViewController<Commit> {
        itemsListFactory.makeCommitsViewController(repository: repository, actions: actions)
    }
}
