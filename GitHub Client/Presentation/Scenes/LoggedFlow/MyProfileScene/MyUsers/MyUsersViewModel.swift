//
//  MyUsersViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import UIKit

enum MyUsersViewModelType {
    case followers
    case following
}

struct MyUsersViewModelActions {
    var showUser: (User) -> Void
}

protocol MyUsersViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
}

protocol MyUsersViewModelOutput {
    var title: Observable<String> { get }
    var users: Observable<[User]> { get }
}

typealias MyUsersViewModel = MyUsersViewModelInput & MyUsersViewModelOutput

final class MyUsersViewModelImpl: MyUsersViewModel {

    // MARK: - Output

    var title: Observable<String>
    var users: Observable<[User]> = Observable([])

    // MARK: - Private variables

    private let myProfileUseCase: MyProfileUseCase
    private let type: MyUsersViewModelType
    private let actions: MyUsersViewModelActions
    private var currentPage = 1
    private var lastPage: Int?

    // MARK: - Lifecycle

    init(myProfileUseCase: MyProfileUseCase,
         type: MyUsersViewModelType,
         actions: MyUsersViewModelActions) {
        self.myProfileUseCase = myProfileUseCase
        self.type = type
        self.actions = actions
        switch type {
        case .followers:
            let title = NSLocalizedString("My Followers", comment: "")
            self.title = Observable(title)
        case .following:
            let title = NSLocalizedString("My Following", comment: "")
            self.title = Observable(title)
        }
    }
}

// MARK: - Input
extension MyUsersViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func didSelectItem(at indexPath: IndexPath) {
        let repository = users.value[indexPath.row]
        actions.showUser(repository)
    }
}

// MARK: - Private
private extension MyUsersViewModelImpl {
    func fetch() {
        switch type {
        case .followers:
            myProfileUseCase.fetchFollowers(page: currentPage, completion: completion(_:))
        case .following:
            myProfileUseCase.fetchFollowing(page: currentPage, completion: completion(_:))
        }
    }

    func completion(_ result: Result<ListResponseModel<User>, Error>) {
        switch result {
        case .success(let response):
            self.lastPage = response.lastPage
            self.users.value.append(contentsOf: response.items)
        case .failure(let error):
            self.handle(error)
        }
    }

    func handle(_ error: Error) {
        assert(false, error.localizedDescription)
    }
}
