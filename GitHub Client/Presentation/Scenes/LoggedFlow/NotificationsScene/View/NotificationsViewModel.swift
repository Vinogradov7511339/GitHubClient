//
//  ExploreCollectionViewLayout.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

struct NotificationsActions {
    let openIssue: (URL) -> Void
}

protocol NotificationsViewModelInput {
    func viewDidLoad()
    func refresh()
    func reload()
    func loadNext()

    func didSelectItem(at indexPath: IndexPath)
}

protocol NotificationsViewModelOutput: AnyObject {
    var state: Observable<ItemsSceneState<EventNotification>> { get }
}

typealias NotificationsViewModel = NotificationsViewModelInput & NotificationsViewModelOutput

final class NotificationsViewModelImpl: NotificationsViewModel {

    // MARK: - Output

    var state: Observable<ItemsSceneState<EventNotification>> = Observable(.loading)

    // MARK: - Private variables

    private let useCase: NotificationsUseCase
    private let actions: NotificationsActions
    private var currentPage = 1
    private var lastPage = 1
    private var items: [EventNotification] = []

    init(useCase: NotificationsUseCase, actions: NotificationsActions) {
        self.useCase = useCase
        self.actions = actions
    }
}

// MARK: - Input
extension NotificationsViewModelImpl {
    func viewDidLoad() {
        state.value = .loading
        fetch()
    }

    func reload() {
        state.value = .loading
        loadFirstPage()
    }

    func refresh() {
        state.value = .refreshing
        loadFirstPage()
    }

    func loadNext() {
        guard case .loaded(_ ,_) = state.value else { return }
        guard lastPage > currentPage else { return }
        state.value = .loadingNext
        loadNextPage()
    }

    func didSelectItem(at indexPath: IndexPath) {
        guard case .loaded(let items, _) = state.value else { return }
        let item = items[indexPath.row]
        switch item.type {
        case .issue:
            if let issueUrl = item.notification.subject.url {
                actions.openIssue(issueUrl)
            }
        case .unknown:
            break
        }
    }
}

// MARK: - Private
private extension NotificationsViewModelImpl {
    func loadNextPage() {
        currentPage += 1
        fetch()
    }

    func loadFirstPage() {
        items.removeAll()
        currentPage = 1
        fetch()
    }

    func fetch() {
        useCase.fetch(currentPage) { result in
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

    func calculateIndexPaths(_ newItems: [EventNotification]) -> [IndexPath] {
        let startIndex = items.count - newItems.count
        let endIndex = startIndex + newItems.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
