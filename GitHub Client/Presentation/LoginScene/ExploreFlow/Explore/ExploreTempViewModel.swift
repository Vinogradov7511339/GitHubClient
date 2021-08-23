//
//  ExploreTempViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

protocol ExploreTempViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
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

    // MARK: - Lifecycle

    init(searchResultsViewModel: SearchResultViewModel, useCase: ExploreTempUseCase) {
        self.searchResultsViewModel = searchResultsViewModel
        self.useCase = useCase
    }
}

// MARK: - Input
extension ExploreTempViewModelImpl {
    func viewDidLoad() {
        useCase.mostStarred { result in
            switch result {
            case .success(let response):
                self.popular.value = response.items
            case.failure(let error):
                self.handle(error)
            }
        }
    }

    func didSelectItem(at indexPath: IndexPath) {}
}

// MARK: - Private
private extension ExploreTempViewModelImpl {
    func handle(_ error: Error) {
        self.error.value = error
    }
}
