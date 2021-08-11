//
//  HomeDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import UIKit

final class HomeDIContainer {
    struct Actions {
        var showOrganizations: () -> Void
        var openIssue: (Issue) -> Void
        var openPullRequest: (PullRequest) -> Void
        var showRepositories: () -> Void
        var showRepository: (Repository) -> Void
        var showEvent: (Event) -> Void
    }

    let actions: Actions
    private let homeSceneFactory: HomeSceneFactory
    private let itemsListFactory: ItemsListFactory

    init(parentContainer: MainSceneDIContainer, actions: Actions) {
        self.actions = actions
        self.homeSceneFactory = HomeSceneFactoryImpl(dataTransferService: parentContainer.apiDataTransferService, storage: parentContainer.favoritesStorage)
        self.itemsListFactory = ItemsListFactoryImpl(dataTransferService: parentContainer.apiDataTransferService)
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
