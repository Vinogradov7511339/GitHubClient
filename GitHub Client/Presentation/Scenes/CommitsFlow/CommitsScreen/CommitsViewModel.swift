//
//  CommitsViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

struct CommitsActions {
    let showCommit: (URL) -> Void
}

protocol CommitsViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
    func refresh()
}

protocol CommitsViewModelOutput {
    var state: Observable<ItemsSceneState<Commit>> { get }
}

typealias CommitsViewModel = CommitsViewModelInput & CommitsViewModelOutput

final class CommitsViewModelImpl: CommitsViewModel {

    // MARK: - Output

    var state: Observable<ItemsSceneState<Commit>> = Observable(.loading)

    // MARK: - Private variables

    private let url: URL
    private let useCase: ListUseCase
    private let actions: CommitsActions
    private var lastPage: Int?
    private var currentPage = 1

    init(_ url: URL, useCase: ListUseCase, actions: CommitsActions) {
        self.url = url
        self.useCase = useCase
        self.actions = actions
    }
}

// MARK: - Input
extension CommitsViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func didSelectItem(at indexPath: IndexPath) {
        switch state.value {
        case .loaded(let items, _):
            let commit = items[indexPath.row]
            actions.showCommit(commit.url)
        default:
            break
        }
    }

    func refresh() {
        fetch()
    }
}

// MARK: - Private
private extension CommitsViewModelImpl {
    func fetch() {
        state.value = .loading
        let request = ListRequestModel(path: url, page: currentPage)
        useCase.fetchCommits(request) { result in
            switch result {
            case .success(let model):
                self.lastPage = model.lastPage
                self.state.value = .loaded(items: model.items, indexPaths: [])
            case .failure(let error):
                self.state.value = .error(error: error)
            }
        }
    }
}
