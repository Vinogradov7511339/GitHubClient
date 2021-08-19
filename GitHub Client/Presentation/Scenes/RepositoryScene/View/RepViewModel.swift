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
    let showCode: (URL) -> Void
    let showCommits: (Repository) -> Void
    let openLink: (URL) -> Void
    let share: (URL) -> Void
}

protocol RepViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
    func addToFavorites()
    func showCommits()
    func showPullRequests()
    func showEvents()
    func showIssues()
}

protocol RepViewModelOutput {
    var repository: Observable<RepositoryDetails?> { get }
}

typealias RepViewModel = RepViewModelInput & RepViewModelOutput

final class RepViewModelImpl: RepViewModel {


    private let repUseCase: RepUseCase
    private let actions: RepActions
    private let rep: Repository

    // MARK: - OUTPUT

    let repository: Observable<RepositoryDetails?> = Observable(nil)

    // MARK: - Init

    init(repository: Repository, repUseCase: RepUseCase, actions: RepActions) {
//        self.repository = Observable(repository)
        self.rep = repository
        self.repUseCase = repUseCase
        self.actions = actions
    }
}

// MARK: - RepViewModelInput
extension RepViewModelImpl {
    func viewDidLoad() {
        repUseCase.fetch(repository: rep) { result in
            switch result {
            case .success(let text):
                let repository = RepositoryDetails(repository: self.rep, mdText: text)
                self.repository.value = repository
            case .failure(let error):
                self.handle(error)
            }
        }
    }

    func didSelectItem(at indexPath: IndexPath) {
        switch(indexPath.section, indexPath.row) {
        case (1, 0): actions.showCode(rep.contentPath)
        case (1, 1): actions.showIssues(rep)
        case (1, 2): actions.showPullRequests(rep)
//        case (1, 3): actions.showReleases(repository.value)
//        case (1, 4): actions.showWatchers(repository.value)
        case (2, 0): actions.showCommits(rep)
        default: break
        }
    }

    func addToFavorites() {
//        repUseCase.addFavorite(repository: repository.value) { error in
//            self.handle(error)
//        }
    }

    func showCommits() {
//        actions.showCommits(repository.value)
    }

    func showPullRequests() {
//        actions.showPullRequests(repository.value)
    }

    func showEvents() {}

    func showIssues() {
//        actions.showIssues(repository.value)
    }
}

private extension RepViewModelImpl {
    func handle(_ error: Error?) {}
}
