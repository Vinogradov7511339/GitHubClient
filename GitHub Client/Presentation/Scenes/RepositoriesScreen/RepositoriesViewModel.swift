//
//  ForksViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.08.2021.
//

import UIKit

struct RepositoriesActions {
    var showRepository: (URL) -> Void
}

protocol RepositoriesViewModelInput {
    func viewDidLoad()
    func refresh()

    func didSelectItem(at indexPath: IndexPath)
}

protocol RepositoriesViewModelOutput {
    var state: Observable<ItemsSceneState<Repository>> { get }
}

typealias RepositoriesViewModel = RepositoriesViewModelInput & RepositoriesViewModelOutput

final class RepositoriesViewModelImpl: RepositoriesViewModel {

    // MARK: - Output

    var state: Observable<ItemsSceneState<Repository>> = Observable(.loading)

    // MARK: - Private variables

    private let url: URL
    private let useCase: ListUseCase
    private let actions: RepositoriesActions
    private var currentPage: Int = 1
    private var lastPage: Int?

    // MARK: - Lifecycle

    init(_ url: URL, useCase: ListUseCase, actions: RepositoriesActions) {
        self.url = url
        self.useCase = useCase
        self.actions = actions
    }
}

// MARK: - Input
extension RepositoriesViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func refresh() {
        fetch()
    }

    func didSelectItem(at indexPath: IndexPath) {
        guard case .loaded(let items) = state.value else { return }
        actions.showRepository(items[indexPath.row].url)
    }
}

// MARK: - Private
private extension RepositoriesViewModelImpl {
    func fetch() {
        self.state.value = .loading
        let model = ListRequestModel(path: url, page: currentPage)
        useCase.fetchRepositories(model) { result in
            switch result {
            case .success(let model):
                self.lastPage = model.lastPage
                self.state.value = .loaded(items: model.items)
            case .failure(let error):
                self.state.value = .error(error: error)
            }
        }
    }
}
