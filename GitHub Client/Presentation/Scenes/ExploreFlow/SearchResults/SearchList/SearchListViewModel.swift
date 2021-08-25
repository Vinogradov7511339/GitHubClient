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
}

protocol SearchListViewModelInput {
    func viewDidLoad()
    func refresh()
    func loadNextPage()
    func didSelectItem(at indexPath: IndexPath)
}

protocol SearchListViewModelOutput {
    var detailTitle: Observable<(String, String)> { get }
    var isFetching: Observable<Bool> { get }
    var items: Observable<[Any]> { get }
    var type: SearchType { get }
}

typealias SearchListViewModel = SearchListViewModelInput & SearchListViewModelOutput

final class SearchListViewModelImpl: SearchListViewModel {

    // MARK: - Output

    var detailTitle: Observable<(String, String)>
    var isFetching: Observable<Bool> = Observable(false)
    let items: Observable<[Any]> = Observable([])
    let type: SearchType

    // MARK: - Private variables

    private let actions: SearchListActions
    private let useCase: ExploreTempUseCase
    private let searchParameters: String
    private var currentPage = 1
    private var lastPage: Int?

    // MARK: - Lifecycle

    init(actions: SearchListActions,
         type: SearchType,
         useCase: ExploreTempUseCase,
         searchParameters: String) {

        self.actions = actions
        self.type = type
        self.useCase = useCase
        self.searchParameters = searchParameters

        let title: (String, String)
        switch type {
        case .repositories:
            title = ("Repositories", "")
        case .issues:
            title = ("Issues", "")
        case .pullRequests:
            title = ("Pull Requests", "f")
        case .people:
            title = ("Users", "")
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
        currentPage = 1
        fetch()
    }

    func loadNextPage() {
        currentPage += 1
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
        case .people:
            if let user = item as? User {
                actions.showUser(user)
            }
        }
    }
}

// MARK: - Private
private extension SearchListViewModelImpl {
    func calculateIndexPathsToReload(from newItems: [Any]) -> [IndexPath] {
        let startIndex = items.value.count - newItems.count
        let endIndex = startIndex + newItems.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }

    func fetch() {
        guard !isFetching.value else {
            return
        }
        isFetching.value = true

        switch type {
        case .repositories:
            useCase.searchRepositoryByName(searchParameters, page: currentPage, completion: handle(_:))
        case .issues:
            useCase.searchIssueByLabel(searchParameters, page: currentPage, completion: handle(_:))
        case .pullRequests:
            useCase.searchPullRequests(searchParameters, page: currentPage, completion: handle(_:))
        case .people:
            useCase.searchUsersByName(searchParameters, page: currentPage, completion: handle(_:))
        }
    }

    func handle(_ result: Result<SearchResponseModel, Error>) {
        isFetching.value = false
        switch result {
        case .success(let model):
            updateTitle(model.total)
            items.value.append(contentsOf: model.items)
        case .failure(let error):
            handleError(error)
        }
    }

    func handleError(_ error: Error) {
        assert(false, error.localizedDescription)
    }

    func updateTitle(_ totalCount: Int) {
        let formattedTotal = totalCount.separatedBy(".")

        let title: (String, String)
        switch type {
        case .repositories:
            title = ("Repositories", "Total \(formattedTotal)")
        case .issues:
            title = ("Issues", "Total \(formattedTotal)")
        case .pullRequests:
            title = ("Pull Requests", "Total \(formattedTotal)")
        case .people:
            title = ("Users", "Total \(formattedTotal)")
        }
        self.detailTitle.value = title
    }
}
