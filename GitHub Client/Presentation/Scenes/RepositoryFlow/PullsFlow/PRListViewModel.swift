//
//  PRListViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import UIKit

struct PRListActions {
    let show: (PullRequest) -> Void
}

protocol PRListViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
    func refresh()
}

protocol PRListViewModelOutput {
    var state: Observable<ItemsSceneState<PullRequest>> { get }
}

typealias PRListViewModel = PRListViewModelInput & PRListViewModelOutput

final class PRListViewModelImpl: PRListViewModel {

    // MARK: - Output

    var state: Observable<ItemsSceneState<PullRequest>> = Observable(.loading)

    // MARK: - Private variables

    private let url: URL
    private let useCase: PRUseCase
    private let actions: PRListActions
    private var lastPage: Int?
    private var currentPage = 1

    // MARK: - Lifecycle

    init(_ url: URL, useCase: PRUseCase, actions: PRListActions) {
        self.url = url
        self.useCase = useCase
        self.actions = actions
    }
}

// MARK: - Input
extension PRListViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func didSelectItem(at indexPath: IndexPath) {
        switch state.value {
        case .loaded(let items):
            let pullRequest = items[indexPath.row]
            actions.show(pullRequest)
        default:
            break
        }
    }

    func refresh() {
        fetch()
    }
}

// MARK: - Private
private extension PRListViewModelImpl {
    func fetch() {
        state.value = .loading
        useCase.fetchPRList(url, page: currentPage) { result in
            switch result {
            case .success(let model):
                self.lastPage = model.lastPage
                self.state.value = .loaded(items: model.items)
            case .failure(let error):
                self.state.value = .error(error: error)
            }
        }
    }
}
