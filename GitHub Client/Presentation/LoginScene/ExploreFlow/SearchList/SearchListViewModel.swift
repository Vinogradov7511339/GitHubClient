//
//  SearchListViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.08.2021.
//

import UIKit

struct SearchListActions {
    let showRepository: (Repository) -> Void
    let showIssue: (Issue) -> Void
    let showPullRequest: (PullRequest) -> Void
    let showUser: (User) -> Void
    let showOrganization: (Organization) -> Void
}

enum SearchListType {
    case repositories
    case issues
    case pullRequests
    case users
    case organizations
}

protocol SearchListViewModelInput {
    func viewDidLoad()
    func refresh()
    func didSelectItem(at indexPath: IndexPath)
}

protocol SearchListViewModelOutput {
    var detailTitle: Observable<(String, String)> { get }
    var items: Observable<[Any]> { get }
    var type: SearchListType { get }
}

typealias SearchListViewModel = SearchListViewModelInput & SearchListViewModelOutput

final class SearchListViewModelImpl: SearchListViewModel {

    // MARK: - Output

    var detailTitle: Observable<(String, String)>
    let items: Observable<[Any]> = Observable([])
    let type: SearchListType

    // MARK: - Private variables

    private let actions: SearchListActions
    private let useCase: ExploreTempUseCase
    private let searchParameters: String

    // MARK: - Lifecycle

    init(actions: SearchListActions,
         type: SearchListType,
         useCase: ExploreTempUseCase,
         searchParameters: String) {

        self.actions = actions
        self.type = type
        self.useCase = useCase
        self.searchParameters = searchParameters

        let title: (String, String)
        switch type {
        case .repositories:
            title = ("Repository", "from 10000")
        case .issues:
            title = ("Issues", "from 10000")
        case .pullRequests:
            title = ("Pull Requests", "from 10000")
        case .users:
            title = ("Users", "from 10000")
        case .organizations:
            title = ("Organizations", "from 10000")
        }
        detailTitle = Observable<(String, String)>(title)
    }
}

// MARK: - Input
extension SearchListViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func refresh() {
        fetch()
    }

    func didSelectItem(at indexPath: IndexPath) {
        let item = items.value[indexPath.row]
        switch type {
        case .repositories:
            if let repository = item as? Repository {
                actions.showRepository(repository)
            }
        case .issues:
            if let issue = item as? Issue {
                actions.showIssue(issue)
            }
        case .pullRequests:
            if let pullRequest = item as? PullRequest {
                actions.showPullRequest(pullRequest)
            }
        case .users:
            if let user = item as? User {
                actions.showUser(user)
            }
        case .organizations:
            if let org = item as? Organization {
                actions.showOrganization(org)
            }
        }
    }
}

// MARK: - Private
private extension SearchListViewModelImpl {
    func fetch() {

    }

    func searchRepository(_ repName: String) {
        useCase.searchRepositoryByName(repName) { result in
            switch result {
            case .success(let response):
                self.items.value = response.items
            case .failure(let error):
                assert(false, error.localizedDescription)
            }
        }
    }

    func searchIssue(_ label: String) {
        useCase.searchIssueByLabel(label) { result in
            switch result {
            case .success(let response):
                self.items.value = response.items
            case .failure(let error):
                assert(false, error.localizedDescription)
            }
        }
    }

    func searchUser(_ userName: String) {
        useCase.searchUsersByName(userName) { result in
            switch result {
            case .success(let response):
                self.items.value = response.items
            case .failure(let error):
                assert(false, error.localizedDescription)
            }
        }
    }
}
