//
//  SearchResultViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.08.2021.
//

import UIKit

struct SearchResultActions {
    let loadRepList: (String) -> Void
    let loadIssues: (String) -> Void
    let loadPRList: (String) -> Void
    let loadUsers: (String) -> Void

    let showRepository: (URL) -> Void
    let showIssue: (Issue) -> Void
    let showPullRequest: (PullRequest) -> Void
    let showUser: (User) -> Void
}

protocol SearchResultViewModelInput: UISearchResultsUpdating, UISearchBarDelegate {
    func viewDidLoad()
    func didSelectSearchItem(at indexPath: IndexPath)
    func didSelectResultItem(at indexPath: IndexPath)
}

protocol SearchResultViewModelOutput {
    var state: Observable<SearchState> { get }
}

typealias SearchResultViewModel = SearchResultViewModelInput & SearchResultViewModelOutput

final class SearchResultViewModelImpl: NSObject, SearchResultViewModel {

    // MARK: - Output

    var state: Observable<SearchState> = Observable(.empty)

    // MARK: - Private variables

    private let actions: SearchResultActions
    private let useCase: ExploreUseCase
    private var searchText: String = ""

    // MARK: - Lifecycle

    init(actions: SearchResultActions, useCase: ExploreUseCase) {
        self.actions = actions
        self.useCase = useCase
    }
}

// MARK: - Input
extension SearchResultViewModelImpl {
    func viewDidLoad() {}

    func didSelectSearchItem(at indexPath: IndexPath) {
        guard case .typing(let text) = state.value else {
            return
        }
        guard let searchType = SearchType(rawValue: indexPath.row) else {
            assert(false, "no search type")
            return
        }
        switch searchType {
        case .repositories:
            actions.loadRepList(text)
        case .issues:
            actions.loadIssues(text)
        case .pullRequests:
            actions.loadPRList(text)
        case .people:
            actions.loadUsers(text)
        }
    }

    func didSelectResultItem(at indexPath: IndexPath) {
        guard let sectionType = SearchType(rawValue: indexPath.section) else {
            assert(false, "no section type")
            return
        }
        guard case .results(let type) = state.value else {
            return
        }
        guard case .results(let resultModels) = type else {
            return
        }
        guard let model = resultModels[sectionType] else {
            assert(false, "no model for section \(sectionType.rawValue)")
            return
        }
        if indexPath.row < model.items.count {
            let item = model.items[indexPath.row]
            open(item: item)
        } else {
            switch sectionType {
            case .repositories:
                actions.loadRepList(searchText)
            case .issues:
                actions.loadIssues(searchText)
            case .pullRequests:
                actions.loadPRList(searchText)
            case .people:
                actions.loadUsers(searchText)
            }
        }
    }

    private func open(item: Any) {
        if let repository = item as? Repository {
            actions.showRepository(repository.url)
            return
        }
        if let issue = item as? Issue {
            actions.showIssue(issue)
            return
        }
        if let pullRequest = item as? PullRequest {
            actions.showPullRequest(pullRequest)
        }
        if let user = item as? User {
            actions.showUser(user)
        }
    }
}

// MARK: - UISearchResultsUpdating
extension SearchResultViewModelImpl {
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.isActive else { return }
        guard let text = searchController.searchBar.searchTextField.text else {
            state.value = .empty
            return
        }
        self.searchText = text
        state.value = .typing(text: text)
    }
}

// MARK: - UISearchBarDelegate
extension SearchResultViewModelImpl {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        self.searchText = text
        searchAll(text)
    }
}

// MARK: - Private
private extension SearchResultViewModelImpl {
    func searchAll(_ text: String) {
        useCase.searchAllTypesByName(text) { result in
            switch result {
            case .success(let response):
                self.state.value = .results(.results(response))
            case .failure(let error):
                assert(false, error.localizedDescription)
            }
        }
    }
}
