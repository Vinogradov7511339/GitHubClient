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
    let loadOrgList: (String) -> Void

    let showRepository: (Repository) -> Void
    let showIssue: (Issue) -> Void
    let showPullRequest: (PullRequest) -> Void
    let showUser: (User) -> Void
    let showOrganization: (Organization) -> Void
}

enum SearchState {
    case results(SearchResultType)
    case typing(text: String)
    case empty
}

enum SearchResultType {
    case empty
    case repList(SearchResponseModel<Repository>)
    case issues(SearchResponseModel<Issue>)
    case users(SearchResponseModel<User>)
    case all(repList: SearchResponseModel<Repository>,
             issues: SearchResponseModel<Issue>,
             users: SearchResponseModel<User>)
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
    private let useCase: ExploreTempUseCase

    // MARK: - Lifecycle

    init(actions: SearchResultActions, useCase: ExploreTempUseCase) {
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
        switch indexPath.row {
        case 0:
            searchRepository(text)
        case 1:
            searchIssue(text)
        case 3:
            searchUser(text)
        default:
            break
        }
    }

    func didSelectResultItem(at indexPath: IndexPath) {}
}

// MARK: - UISearchResultsUpdating
extension SearchResultViewModelImpl {
    func updateSearchResults(for searchController: UISearchController) {
        if !searchController.isActive {
            return
        }
        if let text = searchController.searchBar.searchTextField.text {
            state.value = .typing(text: text)
        } else {
            state.value = .empty
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchResultViewModelImpl {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchAll(text)
    }
}

// MARK: - Private
private extension SearchResultViewModelImpl {
    func searchRepository(_ repName: String) {
        useCase.searchRepositoryByName(repName) { result in
            switch result {
            case .success(let response):
                self.state.value = .results(.repList(response))
            case .failure(let error):
                assert(false, error.localizedDescription)
            }
        }
    }

    func searchIssue(_ label: String) {
        useCase.searchIssueByLabel(label) { result in
            switch result {
            case .success(let response):
                self.state.value = .results(.issues(response))
            case .failure(let error):
                assert(false, error.localizedDescription)
            }
        }
    }

    func searchUser(_ userName: String) {
        useCase.searchUsersByName(userName) { result in
            switch result {
            case .success(let response):
                self.state.value = .results(.users(response))
            case .failure(let error):
                assert(false, error.localizedDescription)
            }
        }
    }

    func searchAll(_ text: String) {
        useCase.searchAllTypesByName(text) { result in
            switch result {
            case .success(let response):
                self.state.value = .results(.all(repList: response.0,
                                                 issues: response.1,
                                                 users: response.2))
            case .failure(let error):
                assert(false, error.localizedDescription)
            }
        }
    }
}
