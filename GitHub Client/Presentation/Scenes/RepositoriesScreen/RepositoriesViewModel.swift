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

    var url: URL {
        switch self {
        case .repositories(let url): return url
        case .starred(let url): return url
        case .forks(let url): return url
        }
    }

    var title: String {
        switch self {
        case .repositories(_):
            return NSLocalizedString("Repositories", comment: "")
        case .starred(_):
            return NSLocalizedString("Starred", comment: "")
        case .forks(_):
            return NSLocalizedString("Forks", comment: "")
        }
    }
}

protocol RepositoriesViewModelInput {
    func viewDidLoad()
    func refresh()
    func reload()
    func loadNext()

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
    private var currentPage = 1
    private var lastPage = 1
    private var items: [Repository] = []

    // MARK: - Lifecycle

    init(_ type: RepositoriesType, useCase: ListUseCase, actions: RepositoriesActions) {
        self.useCase = useCase
        self.actions = actions
        self.url = type.url
        self.title.value = type.title
    }
}

// MARK: - Input
extension RepositoriesViewModelImpl {
    func viewDidLoad() {
        state.value = .loading
        loadFirstPage()
    }

    func refresh() {
        state.value = .refreshing
        loadFirstPage()
    }

    func reload() {
        state.value = .loading
        loadFirstPage()
    }

    func loadNext() {
        guard case .loaded(_, _) = state.value else { return }
        guard lastPage > currentPage else { return }
        state.value = .loadingNext
        loadNextPage()
    }

    func didSelectItem(at indexPath: IndexPath) {
        guard case .loaded(let items, _) = state.value else { return }
        actions.showRepository(items[indexPath.row].url)
    }
}

// MARK: - Private
private extension RepositoriesViewModelImpl {
    func loadFirstPage() {
        currentPage = 1
        items.removeAll()
        fetch()
    }

    func loadNextPage() {
        currentPage += 1
        fetch()
    }

    func fetch() {
        let model = ListRequestModel(path: url, page: currentPage)
        useCase.fetchRepositories(model) { result in
            switch result {
            case .success(let response):
                self.lastPage = response.lastPage
                self.items.append(contentsOf: response.items)
                let paths = self.calculateIndexPaths(response.items)
                self.state.value = .loaded(items: self.items, indexPaths: paths)
            case .failure(let error):
                self.state.value = .error(error: error)
            }
        }
    }

    func calculateIndexPaths(_ newItems: [Repository]) -> [IndexPath] {
        let startIndex = items.count - newItems.count
        let endIndex = startIndex + newItems.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
