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

enum RepositoriesType {
    case repositories(URL)
    case starred(URL)
    case forks(URL)
}

protocol RepositoriesViewModelInput {
    func viewDidLoad()
    func refresh()

    func didSelectItem(at indexPath: IndexPath)
}

protocol RepositoriesViewModelOutput {
    var title: Observable<String> { get }
    var state: Observable<ItemsSceneState<Repository>> { get }
}

typealias RepositoriesViewModel = RepositoriesViewModelInput & RepositoriesViewModelOutput

final class RepositoriesViewModelImpl: RepositoriesViewModel {

    // MARK: - Output

    var title: Observable<String> = Observable("")
    var state: Observable<ItemsSceneState<Repository>> = Observable(.loading)

    // MARK: - Private variables

    private let url: URL
    private let useCase: ListUseCase
    private let actions: RepositoriesActions
    private var currentPage: Int = 1
    private var lastPage: Int?

    // MARK: - Lifecycle

    init(_ type: RepositoriesType, useCase: ListUseCase, actions: RepositoriesActions) {
        self.useCase = useCase
        self.actions = actions
        switch type {
        case .repositories(let url):
            self.url = url
            self.title.value = NSLocalizedString("Repositories", comment: "")
        case .starred(let url):
            self.url = url
            self.title.value = NSLocalizedString("Starred", comment: "")
        case .forks(let url):
            self.url = url
            self.title.value = NSLocalizedString("Forks", comment: "")
        }
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
        guard case .loaded(let items, _) = state.value else { return }
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
                self.state.value = .loaded(items: model.items, indexPaths: [])
            case .failure(let error):
                self.state.value = .error(error: error)
            }
        }
    }
}
