//
//  UsersListViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import Foundation

struct UsersListActions {
    let showUser: (User) -> Void
}

enum UsersListViewModelLoading {
    case fullScreen
    case nextPage
}

protocol UsersListViewModelInput {
    func viewDidLoad()
    func refresh()
    func didLoadNextPage()
    func didSelectItem(at index: Int)
}

protocol UsersListViewModelOutput {
    var items: Observable<[User]> { get }
    var loading: Observable<UsersListViewModelLoading?> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var emptyDataTitle: String { get }
    var errorTitle: String { get }
}

typealias UsersListViewModel = UsersListViewModelInput & UsersListViewModelOutput

final class UsersListViewModelImpl: UsersListViewModel {

    // MARK: - Output

    let items: Observable<[User]> = Observable([])
    let loading: Observable<UsersListViewModelLoading?> = Observable(.none)
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    let screenTitle = NSLocalizedString("Movies", comment: "")
    let emptyDataTitle = NSLocalizedString("Search results", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    let searchBarPlaceholder = NSLocalizedString("Search Movies", comment: "")

    private let type: UsersListType
    private let useCase: UsersListUseCase
    private let actions: UsersListActions
    
    private var page = 0
    private var lastPage = 1

    init(type: UsersListType, useCase: UsersListUseCase, actions: UsersListActions) {
        self.type = type
        self.useCase = useCase
        self.actions = actions
    }
}

// MARK: - Input
extension UsersListViewModelImpl {
    func viewDidLoad() {
        loading.value = .fullScreen
        useCase.fetchMy(type: type, page: page) { result in
            switch result {
            case .success(let users): self.appendUsers(users)
            case .failure(let error): self.handleError(error)
            }
        }
    }
    
    func refresh() {
        
    }

    func didLoadNextPage() {
        guard page < lastPage else { return }
        loading.value = .nextPage
        useCase.fetchMy(type: type, page: page) { result in
            switch result {
            case .success(let users): self.appendUsers(users)
            case .failure(let error): self.handleError(error)
            }
        }
    }

    func didSelectItem(at index: Int) {
        let user = items.value[index]
        actions.showUser(user)
    }
}

// MARK: - Private
private extension UsersListViewModelImpl {
    func appendUsers(_ newUsers: [User]) {
        loading.value = .none

    }
    func handleError(_ error: Error) {
    }
}
