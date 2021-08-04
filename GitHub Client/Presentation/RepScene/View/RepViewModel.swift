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
    var items: Observable<[[Any]]> { get }
}

typealias RepViewModel = RepViewModelInput & RepViewModelOutput

final class RepViewModelImpl: RepViewModel {
    
    private let repository: Repository
    private let repUseCase: RepUseCase
    private let actions: RepActions

    // MARK: - OUTPUT
    var items: Observable<[[Any]]> = Observable([[]])

    // MARK: - Init

    init(repository: Repository, repUseCase: RepUseCase, actions: RepActions) {
        self.repository = repository
        self.repUseCase = repUseCase
        self.actions = actions
    }
}

// MARK: - RepViewModelInput
extension RepViewModelImpl {
    func viewDidLoad() {
        
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        switch(indexPath.section, indexPath.row) {
        case (0, 1): actions.showIssues(repository)
        case (0, 2): actions.showPullRequests(repository)
        case (0, 3): actions.showReleases(repository)
        case (0, 4): actions.showWatchers(repository)
        case (1, 0): actions.showCode(repository)
        case (1, 1): actions.showCommits(repository)
        default: break
        }
    }
}
