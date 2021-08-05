//
//  ItemsListViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import UIKit

struct ItemsListActions<Item> {
    let showDetails: (Item) -> Void
}

enum ItemsListViewModelLoadingState {
    case fullScreen
    case nextPage
}

protocol ItemsListViewModelInput {
    func viewDidLoad()
    func refresh()
    func didLoadNextPage()
    func didSelectItem(at index: Int)
}

protocol ItemsListViewModelOutput {
    associatedtype Item
    var items: Observable<[Item]> { get }
    var loading: Observable<ItemsListViewModelLoadingState?> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var emptyDataTitle: String { get }
    var errorTitle: String { get }
}

typealias ItemsListViewModel = ItemsListViewModelInput & ItemsListViewModelOutput

final class ItemsListViewModelImpl<Item>: ItemsListViewModel {
    // MARK: - Output

    let items: Observable<[Item]> = Observable([])
    let loading: Observable<ItemsListViewModelLoadingState?> = Observable(.none)
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    let screenTitle = NSLocalizedString("Movies", comment: "")
    let emptyDataTitle = NSLocalizedString("Search results", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    let searchBarPlaceholder = NSLocalizedString("Search Movies", comment: "")

    private let type: ListType
    private let useCase: ItemsListUseCase
    private let actions: ItemsListActions<Item>

    private var page = 0
    private var lastPage = 1

    init(type: ListType, useCase: ItemsListUseCase, actions: ItemsListActions<Item>) {
        self.type = type
        self.useCase = useCase
        self.actions = actions
    }
}

// MARK: - Input
extension ItemsListViewModelImpl {
    func viewDidLoad() {
        loading.value = .fullScreen
        useCase.fetch(request: createRequestModel()) { result in
            switch result {
            case .success(let users): self.handleResponse(users)
            case .failure(let error): self.handleError(error)
            }
        }
    }

    func refresh() {
        
    }

    func didLoadNextPage() {
        guard page < lastPage else { return }
        loading.value = .nextPage
        useCase.fetch(request: createRequestModel()) { result in
            switch result {
            case .success(let users): self.handleResponse(users)
            case .failure(let error): self.handleError(error)
            }
        }
    }

    func didSelectItem(at index: Int) {
        let item = items.value[index]
        actions.showDetails(item)
    }
}

// MARK: - Private
private extension ItemsListViewModelImpl {
    func handleResponse(_ response: ItemsListResponseModel) {
        loading.value = .none

    }
    func handleError(_ error: Error) {
    }

    func createRequestModel() -> ItemsListRequestModel {
        .init(page: page, listType: type)
    }
}
