//
//  ExploreFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

protocol ExploreFactory {
    func exploreViewController(exploreActions: ExploreActions, _ actions: SearchResultActions) -> UIViewController
    func searchFilterViewController() -> UIViewController

    func repListViewController(_ searchQuery: String, actions: SearchListActions) -> UIViewController
    func issuesViewController(_ searchQuery: String, actions: SearchListActions) -> UIViewController
    func pullRequestsViewController(_ searchQuery: String, actions: SearchListActions) -> UIViewController
    func usersViewController(_ searchQuery: String, actions: SearchListActions) -> UIViewController
}

final class ExploreFactoryImpl {

    private let dataTransferService: DataTransferService
    private let searchFilterStorage: SearchFilterStorage
    private let exploreSettingsStorage: ExploreWidgetsRequestStorage

    init(dataTransferService: DataTransferService,
         searchFilterStorage: SearchFilterStorage,
         exploreSettingsStorage: ExploreWidgetsRequestStorage) {

        self.dataTransferService = dataTransferService
        self.searchFilterStorage = searchFilterStorage
        self.exploreSettingsStorage = exploreSettingsStorage
    }
}

// MARK: - ExploreFactory
extension ExploreFactoryImpl: ExploreFactory {
    func exploreViewController(exploreActions: ExploreActions, _ actions: SearchResultActions) -> UIViewController {
        ExploreViewController.create(with: exploreViewModel(exploreActions: exploreActions, actions))
    }

    func searchFilterViewController() -> UIViewController {
        SearchFilterViewController.create(with: searchFilterStorage)
    }

    func repListViewController(_ searchQuery: String, actions: SearchListActions) -> UIViewController {
        SearchListViewController.create(with: repSearchListViewModel(searchQuery, actions: actions))
    }

    func issuesViewController(_ searchQuery: String, actions: SearchListActions) -> UIViewController {
        SearchListViewController.create(with: issuesSearchListViewModel(searchQuery, actions: actions))
    }

    func pullRequestsViewController(_ searchQuery: String, actions: SearchListActions) -> UIViewController {
        SearchListViewController.create(with: pullRequestsSearchListViewModel(searchQuery, actions: actions))
    }

    func usersViewController(_ searchQuery: String, actions: SearchListActions) -> UIViewController {
        SearchListViewController.create(with: usersSearchListViewModel(searchQuery, actions: actions))
    }
}

// MARK: - SearchList view models
private extension ExploreFactoryImpl {
    func repSearchListViewModel(_ searchQuery: String, actions: SearchListActions) -> SearchListViewModel {
        SearchListViewModelImpl(actions: actions,
                                type: .repositories,
                                useCase: exploreUseCase,
                                searchParameters: searchQuery)
    }

    func issuesSearchListViewModel(_ searchQuery: String, actions: SearchListActions) -> SearchListViewModel {
        SearchListViewModelImpl(actions: actions,
                                type: .issues,
                                useCase: exploreUseCase,
                                searchParameters: searchQuery)
    }

    func pullRequestsSearchListViewModel(_ searchQuery: String,
                                         actions: SearchListActions) -> SearchListViewModel {
        SearchListViewModelImpl(actions: actions,
                                type: .pullRequests,
                                useCase: exploreUseCase,
                                searchParameters: searchQuery)
    }

    func usersSearchListViewModel(_ searchQuery: String, actions: SearchListActions) -> SearchListViewModel {
        SearchListViewModelImpl(actions: actions,
                                type: .people,
                                useCase: exploreUseCase,
                                searchParameters: searchQuery)
    }
}

// MARK: - Explore view models
private extension ExploreFactoryImpl {
    func exploreViewModel(exploreActions: ExploreActions, _ actions: SearchResultActions) -> ExploreViewModel {
        ExploreViewModelImpl(actions: exploreActions,
                                 searchResultsViewModel: searchResultViewModel(actions),
                                 useCase: exploreUseCase,
                                 exploreSettingsStorage: exploreSettingsStorage)
    }

    func searchResultViewModel(_ actions: SearchResultActions) -> SearchResultViewModel {
        SearchResultViewModelImpl(actions: actions, useCase: exploreUseCase)
    }
}

// MARK: - Private
private extension ExploreFactoryImpl {
    var exploreUseCase: ExploreUseCase {
        ExploreUseCaseImpl(searchFilterStorage: searchFilterStorage, exploreRepository: exploreRepository)
    }

    var exploreRepository: ExploreTempRepository {
        ExploreTempRepositoryImpl(dataTransferService: dataTransferService)
    }
}
