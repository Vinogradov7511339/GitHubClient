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
    var title: Observable<String> { get }
    var items: Observable<[Any]> { get }
    var type: SearchListType { get }
}

typealias SearchListViewModel = SearchListViewModelInput & SearchListViewModelOutput

final class SearchListViewModelImpl: SearchListViewModel {

    // MARK: - Output

    let title: Observable<String>
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

        switch type {
        case .repositories:
            title = Observable<String>("Repository")
        case .issues:
            title = Observable<String>("Issues")
        case .pullRequests:
            title = Observable<String>("Pull Requests")
        case .users:
            title = Observable<String>("Users")
        case .organizations:
            title = Observable<String>("Organizations")
        }
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
}
