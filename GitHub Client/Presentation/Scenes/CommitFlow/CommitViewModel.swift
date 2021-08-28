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
}

protocol CommitViewModelOutput {}

typealias CommitViewModel = CommitViewModelInput & CommitViewModelOutput

final class CommitViewModelImpl: CommitViewModel {

    // MARK: - Private variables

    private let commitUrl: URL
    private let useCase: RepUseCase
    private let actions: CommitActions

    init(commitUrl: URL, useCase: RepUseCase, actions: CommitActions) {
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
}

// MARK: - Private
private extension CommitViewModelImpl {
    func fetch() {}
}
