//
//  UsersListViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 12.08.2021.
//

import UIKit

struct UsersListActions {
    let showUser: (User) -> Void
}

protocol UsersListViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
}

protocol UsersListViewModelOutput {
    var users: Observable<[User]> { get }
}

typealias UsersListViewModel = UsersListViewModelInput & UsersListViewModelOutput

final class UsersListViewModelImpl: UsersListViewModel {

    // MARK: - Output
    var users: Observable<[User]> = Observable([])

    // MARK: - Private
    private let useCase: UsersUseCase
    private let type: UsersListType
    private let actions: UsersListActions
    private var lastPage: Int?

    init(useCase: UsersUseCase, type: UsersListType, actions: UsersListActions) {
        self.useCase = useCase
        self.type = type
        self.actions = actions
    }
}

// MARK: - Input
extension UsersListViewModelImpl {
    func viewDidLoad() {
        let page = 1
        let request = UsersRequestModel(page: page, listType: type)
        useCase.fetchUsers(request: request) { result in
            switch result {
            case .success(let model):
                self.lastPage = model.lastPage
                self.users.value.append(contentsOf: model.items)
            case .failure(let error):
                print(error)
            }
        }
    }

    func didSelectItem(at indexPath: IndexPath) {
        actions.showUser(users.value[indexPath.row])
    }
}
