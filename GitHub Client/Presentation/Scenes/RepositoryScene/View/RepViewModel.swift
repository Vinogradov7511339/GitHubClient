//
//  RepViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

struct RepActions {
    let showStargazers: (Repository) -> Void
    let showForks: (Repository) -> Void
    let showOwner: (User) -> Void
    let showIssues: (Repository) -> Void
    let showPullRequests: (Repository) -> Void
    let showReleases: (Repository) -> Void
    let showWatchers: (Repository) -> Void
    let showCode: (Repository) -> Void
    let showCommits: (Repository) -> Void
    let openLink: (URL) -> Void
    let share: (URL) -> Void
}

protocol RepViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
}

protocol RepViewModelOutput {

    var repository: Observable<Repository> { get }
    var adapter: ExtendedRepositoryAdapter { get }
}

typealias RepViewModel = RepViewModelInput & RepViewModelOutput

final class RepViewModelImpl: RepViewModel {
    
    let repository: Observable<Repository>
    private let repUseCase: RepUseCase
    private let actions: RepActions

    // MARK: - OUTPUT
    let adapter: ExtendedRepositoryAdapter

    // MARK: - Init

    init(repository: Repository, repUseCase: RepUseCase, actions: RepActions) {
        self.repository = Observable(repository)
        self.repUseCase = repUseCase
        self.actions = actions
        adapter = ExtendedRepositoryAdapterImpl(repository: repository)
    }
}

// MARK: - RepViewModelInput
extension RepViewModelImpl {
    func viewDidLoad() {
        
    }

    func didSelectItem(at indexPath: IndexPath) {
        switch(indexPath.section, indexPath.row) {
        case (0, 1): actions.showIssues(repository.value)
        case (0, 2): actions.showPullRequests(repository.value)
        case (0, 3): actions.showReleases(repository.value)
        case (0, 4): actions.showWatchers(repository.value)
        case (1, 0): actions.showCode(repository.value)
        case (1, 1): actions.showCommits(repository.value)
        default: break
        }
    }
}
