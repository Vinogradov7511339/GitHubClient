//
//  CommitViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 28.08.2021.
//

import UIKit

struct CommitActions {}

protocol CommitViewModelInput {
    func viewDidLoad()
    func refresh()

    func showAuthor()
    func showParentCommit()
}

protocol CommitViewModelOutput {
    var state: Observable<DetailsScreenState<Commit>> { get }
}

typealias CommitViewModel = CommitViewModelInput & CommitViewModelOutput

final class CommitViewModelImpl: CommitViewModel {

    // MARK: - Output

    var state: Observable<DetailsScreenState<Commit>> = Observable(.loading)

    // MARK: - Private variables

    private let commitUrl: URL
    private let useCase: CommitUseCase
    private let actions: CommitActions

    init(commitUrl: URL, useCase: CommitUseCase, actions: CommitActions) {
        self.commitUrl = commitUrl
        self.useCase = useCase
        self.actions = actions
    }
}

// MARK: - Input
extension CommitViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func refresh() {
        fetch()
    }

    func showAuthor() {}

    func showParentCommit() {}
}

// MARK: - Private
private extension CommitViewModelImpl {
    func fetch() {
        state.value = .loading
        useCase.fetchCommit(commitUrl: commitUrl) { result in
            switch result {
            case .success(let commit):
                self.state.value = .loaded(commit)
            case .failure(let error):
                self.state.value = .error(error)
            }
        }
    }
}
