//
//  MyRepositoriesViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import UIKit

enum MyRepositoriesViewModelType {
    case all
    case starred
}

struct MyRepositoriesActions {
    var showRepository: (Repository) -> Void
}

protocol MyRepositoriesViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
}

protocol MyRepositoriesViewModelOutput {
    var title: Observable<String> { get }
    var repositories: Observable<[Repository]> { get }
}

typealias MyRepositoriesViewModel = MyRepositoriesViewModelInput & MyRepositoriesViewModelOutput

final class MyRepositoriesViewModelImpl: MyRepositoriesViewModel {

    // MARK: - Output

    var title: Observable<String>
    var repositories: Observable<[Repository]> = Observable([])

    // MARK: - Private variables

    private let myProfileUseCase: MyProfileUseCase
    private let type: MyRepositoriesViewModelType
    private let actions: MyRepositoriesActions
    private var currentPage = 1
    private var lastPage: Int?

    // MARK: - Lifecycle

    init(myProfileUseCase: MyProfileUseCase,
         type: MyRepositoriesViewModelType,
         actions: MyRepositoriesActions) {
        self.myProfileUseCase = myProfileUseCase
        self.type = type
        self.actions = actions
        switch type {
        case .all:
            let title = NSLocalizedString("My Repositories", comment: "")
            self.title = Observable(title)
        case .starred:
            let title = NSLocalizedString("My Starred", comment: "")
            self.title = Observable(title)
        }
    }
}

// MARK: - Input
extension MyRepositoriesViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func didSelectItem(at indexPath: IndexPath) {
        let repository = repositories.value[indexPath.row]
        actions.showRepository(repository)
    }
}

// MARK: - Private
private extension MyRepositoriesViewModelImpl {
    func fetch() {
        switch type {
        case .all:
            myProfileUseCase.fetchRepList(page: currentPage, completion: completion(_:))
        case .starred:
            myProfileUseCase.fetchStarred(page: currentPage, completion: completion(_:))
        }
    }

    func completion(_ result: Result<ListResponseModel<Repository>, Error>) {
        switch result {
        case .success(let response):
            self.lastPage = response.lastPage
            self.repositories.value.append(contentsOf: response.items)
        case .failure(let error):
            self.handle(error)
        }
    }

    func handle(_ error: Error) {
        assert(false, error.localizedDescription)
    }
}
