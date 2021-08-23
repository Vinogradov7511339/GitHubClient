//
//  SearchResultViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.08.2021.
//

import UIKit

enum SearchState {
    case results(repositories: [Repository], total: Int)
    case typing(text: String)
    case empty
}

protocol SearchResultViewModelInput: UISearchResultsUpdating {
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

    private let useCase: ExploreTempUseCase

    // MARK: - Lifecycle

    init(useCase: ExploreTempUseCase) {
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

private extension SearchResultViewModelImpl {
    func searchRepository(_ repName: String) {
        useCase.searchRepositoryByName(repName, completion: handle(_:))
    }

    func handle(_ result: Result<SearchResponseModel<Repository>, Error>) {
        switch result {
        case .success(let response):
            state.value = .results(repositories: response.items, total: response.total)
        case .failure(let error):
            assert(false, error.localizedDescription)
        }
    }
}
