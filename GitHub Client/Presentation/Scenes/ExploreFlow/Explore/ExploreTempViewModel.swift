//
//  ExploreTempViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

struct ExploreActions {
    let openFilter: () -> Void
    let openRepository: (Repository) -> Void
}

protocol ExploreTempViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
    func openFilter()
    func openPopularSettings()
}

protocol ExploreTempViewModelOutput {
    var error: Observable<Error?> { get }
    var popularTitle: Observable<String> { get }
    var popular: Observable<[Repository]> { get }
    var searchResultsViewModel: SearchResultViewModel { get }
}

typealias ExploreTempViewModel = ExploreTempViewModelInput & ExploreTempViewModelOutput

final class ExploreTempViewModelImpl: ExploreTempViewModel {

    // MARK: - Output

    var error: Observable<Error?> = Observable(nil)
    var popularTitle: Observable<String> = Observable("")
    var popular: Observable<[Repository]> = Observable([])
    var searchResultsViewModel: SearchResultViewModel

    // MARK: - Private variables

    private let useCase: ExploreTempUseCase
    private let actions: ExploreActions
    private let requestModel: SearchRequestModel

    // MARK: - Lifecycle

    init(actions: ExploreActions,
         searchResultsViewModel: SearchResultViewModel,
         useCase: ExploreTempUseCase,
         exploreSettingsStorage: ExploreSettingsStorage) {

        self.actions = actions
        self.searchResultsViewModel = searchResultsViewModel
        self.useCase = useCase
        switch exploreSettingsStorage.searchType {
        case .mostStarred(let model):
            self.requestModel = model
            self.popularTitle.value = NSLocalizedString("Most starred", comment: "")
        }
    }
}

// MARK: - Input
extension ExploreTempViewModelImpl {
    func viewDidLoad() {
        useCase.mostStarred(requestModel) { result in
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

    func didSelectItem(at indexPath: IndexPath) {
        let repository = popular.value[indexPath.row]
        actions.openRepository(repository)
    }

    func openFilter() {
        actions.openFilter()
    }

    func openPopularSettings() {}
}

// MARK: - Private
private extension ExploreTempViewModelImpl {
    func handle(_ error: Error) {
        self.error.value = error
    }
}
