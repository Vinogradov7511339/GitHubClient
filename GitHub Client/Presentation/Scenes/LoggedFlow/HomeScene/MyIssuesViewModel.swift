//
//  MyIssuesViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.09.2021.
//

import UIKit

struct MyIssuesActions {
    let showIssue: (Issue) -> Void
}

protocol MyIssuesViewModelInput {
    func viewDidLoad()
    func refresh()

    func didSelectItem(at indexPath: IndexPath)
}

protocol MyIssuesViewModelOutput {
    var state: Observable<ItemsSceneState<Issue>> { get }
}

typealias MyIssuesViewModel = MyIssuesViewModelInput & MyIssuesViewModelOutput

final class MyIssuesViewModelImpl: MyIssuesViewModel {

    // MARK: - Output

    var state: Observable<ItemsSceneState<Issue>> = Observable(.loading)

    // MARK: - Private variables

    private let useCase: HomeUseCase
    private let actions: MyIssuesActions
    private var currentPage = 1
    private var lastPage = 1

    // MARK: - Lifecycle

    init(useCase: HomeUseCase, actions: MyIssuesActions) {
        self.useCase = useCase
        self.actions = actions
    }
}

// MARK: - Input
extension MyIssuesViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func refresh() {
        fetch()
    }

    func didSelectItem(at indexPath: IndexPath) {
        guard case .loaded(let items, _) = state.value else { return }
        let issue = items[indexPath.row]
        actions.showIssue(issue)
    }
}

// MARK: - Private
private extension MyIssuesViewModelImpl {
    func fetch() {
        state.value = .loading
        useCase.fetchIssues(currentPage) { result in
            switch result {
            case .success(let response):
                self.lastPage = response.lastPage
                self.state.value = .loaded(items: response.items, indexPaths: [])
            case .failure(let error):
                self.state.value = .error(error: error)
            }
        }
    }
}
