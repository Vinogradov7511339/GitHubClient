//
//  ExploreFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

protocol ExploreFactory {
    func exploreViewController(_ actions: SearchResultActions) -> UIViewController

    func repListViewController(_ searchQuery: String, actions: SearchListActions) -> UIViewController
    func issuesViewController(_ searchQuery: String, actions: SearchListActions) -> UIViewController
    func pullRequestsViewController(_ searchQuery: String, actions: SearchListActions) -> UIViewController
    func usersViewController(_ searchQuery: String, actions: SearchListActions) -> UIViewController
}

final class ExploreFactoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - ExploreFactory
extension ExploreFactoryImpl: ExploreFactory {
    func exploreViewController(_ actions: SearchResultActions) -> UIViewController {
        ExploreTempViewController.create(with: exploreViewModel(actions))
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
                                type: .users,
                                useCase: exploreUseCase,
                                searchParameters: searchQuery)
    }
}

// MARK: - Explore view models
private extension ExploreFactoryImpl {
    func exploreViewModel(_ actions: SearchResultActions) -> ExploreTempViewModel {
        ExploreTempViewModelImpl(searchResultsViewModel: searchResultViewModel(actions),
                                 useCase: exploreUseCase)
    }

    func searchResultViewModel(_ actions: SearchResultActions) -> SearchResultViewModel {
        SearchResultViewModelImpl(actions: actions, useCase: exploreUseCase)
    }
}

// MARK: - Private
private extension ExploreFactoryImpl {
    var exploreUseCase: ExploreTempUseCase {
        ExploreTempUseCaseImpl(exploreRepository: exploreRepository)
    }

    var exploreRepository: ExploreTempRepository {
        ExploreTempRepositoryImpl(dataTransferService: dataTransferService)
    }
}
