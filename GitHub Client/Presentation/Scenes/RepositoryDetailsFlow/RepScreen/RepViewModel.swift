//
//  RepViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

struct RepActions {
    let showBranches: (Repository, @escaping (Branch) -> Void) -> Void
    let showStargazers: (Repository) -> Void
    let showForks: (Repository) -> Void
    let showOwner: (User) -> Void
    let showIssues: (Repository) -> Void
    let showPullRequests: (Repository) -> Void
    let showReleases: (Repository) -> Void
    let showWatchers: (Repository) -> Void
    let showCode: (URL) -> Void
    let showCommits: (Repository, String) -> Void
    let openLink: (URL) -> Void
    let share: (URL) -> Void
}

protocol RepViewModelInput {
    func viewDidLoad()
    func refresh()

    func showStargazers()
    func showForks()

    func addToStarred()
    func subscribe()

    func showBranches()
    func showCommits()
    func showSources()

    func showIssues()
    func showPullRequests()
    func showReleases()
    func showLicense()
    func showWatchers()

}

protocol RepViewModelOutput {
    var title: Observable<String> { get }
    var repository: Observable<RepositoryDetails?> { get }
}

typealias RepViewModel = RepViewModelInput & RepViewModelOutput

final class RepViewModelImpl: RepViewModel {

    // MARK: - OUTPUT

    let repository: Observable<RepositoryDetails?> = Observable(nil)
    var title: Observable<String>

    // MARK: - Private variables

    private let repUseCase: RepUseCase
    private let actions: RepActions
    private let rep: Repository
    private var currentBranch: String

    // MARK: - Init

    init(repository: Repository, repUseCase: RepUseCase, actions: RepActions) {
        self.rep = repository
        self.repUseCase = repUseCase
        self.actions = actions
        self.currentBranch = rep.currentBranch
        title = Observable(repository.name)
    }
}

// MARK: - RepViewModelInput
extension RepViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func refresh() {
        fetch()
    }

    func showStargazers() {
        actions.showStargazers(rep)
    }

    func showForks() {
        actions.showForks(rep)
    }

    func addToStarred() {}

    func subscribe() {}

    func addToFavorites() {}

    func showBranches() {
        actions.showBranches(rep, updateBranch(newBranch:))
    }

    func showCommits() {
        actions.showCommits(rep, currentBranch)
    }

    func showSources() {
        actions.showCode(rep.contentPath)
    }

    func showIssues() {
        actions.showIssues(rep)
    }

    func showPullRequests() {}

    func showReleases() {}

    func showLicense() {}

    func showWatchers() {}
}

private extension RepViewModelImpl {
    func updateBranch(newBranch: Branch) {
        currentBranch = newBranch.name
    }

    func fetch() {
        repUseCase.fetchRepository(repository: rep) { result in
            switch result {
            case .success(let repository):
                self.repository.value = repository
            case .failure(let error):
                self.handle(error)
            }
        }
    }
    func handle(_ error: Error) {
        assert(false, "error happen \(error)")
    }
}
