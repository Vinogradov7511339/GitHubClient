//
//  ExploreViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

struct ExploreActions {
    let openFilter: () -> Void
    let openPopularMenu: () -> Void
    let openRepository: (URL) -> Void
}

protocol ExploreViewModelInput {
    func viewDidLoad()
    func reload()
    func didSelectItem(at indexPath: IndexPath)
    func openFilter()
    func openPopularSettings()
}

protocol ExploreViewModelOutput {
    var error: Observable<Error?> { get }
    var popularTitle: Observable<String> { get }
    var popular: Observable<[Repository]> { get }
    var searchResultsViewModel: SearchResultViewModel { get }
}

typealias ExploreViewModel = ExploreViewModelInput & ExploreViewModelOutput

final class ExploreViewModelImpl: ExploreViewModel {

    // MARK: - Output

    var error: Observable<Error?> = Observable(nil)
    var popularTitle: Observable<String> = Observable("")
    var popular: Observable<[Repository]> = Observable([])
    var searchResultsViewModel: SearchResultViewModel

    // MARK: - Private variables

    private let useCase: ExploreUseCase
    private let actions: ExploreActions
    private let requestModel: SearchRequestModel

    // MARK: - Lifecycle

    init(actions: ExploreActions,
         searchResultsViewModel: SearchResultViewModel,
         useCase: ExploreUseCase,
         exploreSettingsStorage: ExploreWidgetsRequestStorage) {

        self.actions = actions
        self.searchResultsViewModel = searchResultsViewModel
        self.useCase = useCase
        self.requestModel = exploreSettingsStorage.model(for: .mostStarred)
        self.popularTitle.value = NSLocalizedString("Most starred", comment: "")
    }
}

// MARK: - Input
extension ExploreViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func reload() {
        fetch()
    }

    func didSelectItem(at indexPath: IndexPath) {
        let repository = popular.value[indexPath.row]
        actions.openRepository(repository.url)
    }

    func openFilter() {
        actions.openFilter()
    }

    func openPopularSettings() {
        actions.openPopularMenu()
    }
}

// MARK: - Private
private extension ExploreViewModelImpl {
    func fetch() {
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
    func handle(_ error: Error) {
        self.error.value = error
    }
}
