//
//  ForksViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.08.2021.
//

import UIKit

struct ForksActions {
    var showRepository: (Repository) -> Void
}

protocol ForksViewModelInput {
    func viewDidLoad()
    func refresh()

    func didSelectItem(at indexPath: IndexPath)
}

protocol ForksViewModelOutput {
    var state: Observable<ItemsSceneState<Repository>> { get }
}

typealias ForksViewModel = ForksViewModelInput & ForksViewModelOutput

final class ForksViewModelImpl: ForksViewModel {

    // MARK: - Output

    var state: Observable<ItemsSceneState<Repository>> = Observable(.loading)

    // MARK: - Private variables

    private let url: URL
    private let useCase: RepUseCase
    private let actions: ForksActions
    private var currentPage: Int = 1
    private var lastPage: Int?

    // MARK: - Lifecycle

    init(_ url: URL, useCase: RepUseCase, actions: ForksActions) {
        self.url = url
        self.useCase = useCase
        self.actions = actions
    }
}

// MARK: - Input
extension ForksViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func refresh() {
        fetch()
    }

    func didSelectItem(at indexPath: IndexPath) {
        guard case .loaded(let items) = state.value else { return }
        actions.showRepository(items[indexPath.row])
    }
}

// MARK: - Private
private extension ForksViewModelImpl {
    func fetch() {
        self.state.value = .loading
        let model = ForksRequestModel(path: url, page: currentPage)
        useCase.fetchForks(request: model) { result in
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
