//
//  RepositoryUsersViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.08.2021.
//

import UIKit

struct UsersActions {
    let showUser: (URL) -> Void
}

enum RepositoryUsersType {
    case following(URL)
    case followers(URL)

    case stargazers(URL)
    case subscribers(URL)
    case contributors(URL)

    var url: URL {
        switch self {
        case .followers(let url): return url
        case .following(let url): return url

        case .stargazers(let url): return url
        case .subscribers(let url): return url
        case .contributors(let url): return url
        }
    }

    var title: String {
        switch self {
        case .followers(_):
            return NSLocalizedString("Followers", comment: "")
        case .following(_):
            return NSLocalizedString("Following", comment: "")
        case .stargazers(_):
            return NSLocalizedString("Stargazers", comment: "")
        case .subscribers(_):
            return NSLocalizedString("Subscribres", comment: "")
        case .contributors(_):
            return NSLocalizedString("Contributors", comment: "")
        }
    }
}

protocol UsersViewModelInput {
    func viewDidLoad()
    func refresh()
    func reload()
    func loadNext()

    func didSelectItem(at indexPath: IndexPath)
}

protocol UsersViewModelOutput {
    var title: Observable<String> { get }
    var state: Observable<ItemsSceneState<User>> { get }
}

typealias UsersViewModel = UsersViewModelInput & UsersViewModelOutput

final class UsersViewModelImpl: UsersViewModel {

    // MARK: - Output

    var title: Observable<String>
    var state: Observable<ItemsSceneState<User>> = Observable(.loading)

    // MARK: - Private variables

    private let type: RepositoryUsersType
    private let useCase: ListUseCase
    private let actions: UsersActions
    private var currentPage = 1
    private var lastPage = 1
    private var items: [User] = []

    // MARK: - Lifecycle

    init(_ type: RepositoryUsersType, useCase: ListUseCase, actions: UsersActions) {
        self.type = type
        self.useCase = useCase
        self.actions = actions
        self.title = Observable(type.title)
    }
}

// MARK: - Input
extension UsersViewModelImpl {
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
        guard case .loaded(let users, _) = state.value else { return }
        actions.showUser(users[indexPath.row].url)
    }
}

// MARK: - Private
private extension UsersViewModelImpl {
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
        useCase.fetchUsers(page: currentPage, type.url) { result in
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

    func calculateIndexPaths(_ newItems: [User]) -> [IndexPath] {
        let startIndex = items.count - newItems.count
        let endIndex = startIndex + newItems.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
