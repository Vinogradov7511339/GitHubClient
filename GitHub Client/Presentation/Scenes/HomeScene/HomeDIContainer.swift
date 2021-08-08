//
//  HomeDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import UIKit

final class HomeDIContainer {
    struct Dependencies {
        let apiDataTransferService: DataTransferService

        var showOrganizations: () -> Void
        var openIssue: (Issue) -> Void
        var openPullRequest: (PullRequest) -> Void
        var showRepositories: () -> Void
        var showRepository: (Repository) -> Void
        var showEvent: (Event) -> Void
    }

    let dependencies: Dependencies
    private let homeSceneFactory: HomeSceneFactory
    private let itemsListFactory: ItemsListFactory
    private let myFavoritesStorage = MyFavoritesStorageImpl()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.homeSceneFactory = HomeSceneFactoryImpl(dataTransferService: dependencies.apiDataTransferService, storage: myFavoritesStorage)
        self.itemsListFactory = ItemsListFactoryImpl(dataTransferService: dependencies.apiDataTransferService)
    }

    func createHomeViewController(actions: HomeActions) -> HomeViewController {
        homeSceneFactory.makeHomeViewController(actions)
    }

    func createIssuesViewController(actions: ItemsListActions<Issue>) -> ItemsListViewController<Issue> {
        itemsListFactory.createMyIssuesViewController(actions: actions)
    }

    func createPullRequestsViewController(actions: ItemsListActions<PullRequest>) -> ItemsListViewController<PullRequest> {
        itemsListFactory.createMyPullRequestsViewController(actions: actions)
    }
}
