//
//  ExploreTempViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

struct ExploreActions {
    let openFilter: () -> Void
}

protocol ExploreTempViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
    func openFilter()
}

protocol ExploreTempViewModelOutput {
    var error: Observable<Error?> { get }
    var popular: Observable<[Repository]> { get }
    var searchResultsViewModel: SearchResultViewModel { get }
}

typealias ExploreTempViewModel = ExploreTempViewModelInput & ExploreTempViewModelOutput

final class ExploreTempViewModelImpl: ExploreTempViewModel {

    // MARK: - Output

    var error: Observable<Error?> = Observable(nil)
    var popular: Observable<[Repository]> = Observable([])
    var searchResultsViewModel: SearchResultViewModel

    // MARK: - Private variables

    private let useCase: ExploreTempUseCase
    private let actions: ExploreActions

    // MARK: - Lifecycle

    init(actions: ExploreActions,
         searchResultsViewModel: SearchResultViewModel,
         useCase: ExploreTempUseCase) {
        self.actions = actions
        self.searchResultsViewModel = searchResultsViewModel
        self.useCase = useCase
    }
}

// MARK: - Input
extension ExploreTempViewModelImpl {
    func viewDidLoad() {
        let searchViewModel = SearchRequestModel(searchType: .repositories, searchText: "stars:>10000", perPage: 10, page: 1)
        useCase.mostStarred(searchViewModel) { result in
            switch result {
            case .success(let response):
                if let repositories = response.items as? [Repository] {
                    self.popular.value = repositories
                } else {
                    self.popular.value = []
                }
            case.failure(let error):
                self.handle(error)
            }
        }
    }

    func didSelectItem(at indexPath: IndexPath) {}

    func openFilter() {
        actions.openFilter()
    }
}

// MARK: - Private
private extension ExploreTempViewModelImpl {
    func handle(_ error: Error) {
        self.error.value = error
    }
}
