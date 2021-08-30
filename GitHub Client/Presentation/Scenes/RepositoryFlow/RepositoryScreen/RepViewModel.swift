//
//  RepViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

struct RepActions {
    let showOwner: (URL) -> Void
    let showStargazers: (URL) -> Void
    let showForks: (URL) -> Void

    let showSources: (URL) -> Void
    let showCommits: (URL) -> Void
    let showBranches: (URL) -> Void
    let showIssues: (URL) -> Void
    let showPulls: (URL) -> Void
    let showReleases: (URL) -> Void
}

protocol RepViewModelInput {
    func viewDidLoad()
    func refresh()

    func showOwner()
    func showStargazers()
    func showForks()
    func showLicense()

    func showSources()
    func showCommits()
    func showBranches()
    func showIssues()
    func showPulls()
    func showReleases()
}

enum RepositoryScreenState {
    case loading
    case loaded(RepositoryDetails)
    case error(Error)
}

protocol RepViewModelOutput {
    var title: Observable<String> { get }
    var state: Observable<RepositoryScreenState> { get }
}

typealias RepViewModel = RepViewModelInput & RepViewModelOutput

final class RepViewModelImpl: RepViewModel {

    // MARK: - OUTPUT

    let state: Observable<RepositoryScreenState> = Observable(.loading)
    var title: Observable<String>

    // MARK: - Private variables

    private let rep: Repository
    private let repUseCase: RepUseCase
    private let actions: RepActions
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

    func showOwner() {
        actions.showOwner(rep.owner.url)
    }

    func showStargazers() {
        actions.showStargazers(rep.stargazersUrl)
    }

    func showForks() {
        actions.showForks(rep.forksUrl)
    }

    func showLicense() {}

    func showSources() {
        actions.showSources(rep.contentUrl)
    }

    func showCommits() {
        actions.showCommits(rep.commitsUrl)
    }

    func showBranches() {
        actions.showBranches(rep.branchesUrl)
    }

    func showIssues() {
        actions.showIssues(rep.issuesUrl)
    }

    func showPulls() {
        actions.showPulls(rep.pullsUrl)
    }

    func showReleases() {
        actions.showReleases(rep.releasesUrl)
    }
}

private extension RepViewModelImpl {
    func updateBranch(newBranch: Branch) {
        currentBranch = newBranch.name
    }

    func fetch() {
        state.value = .loading
        repUseCase.fetchRepository(repository: rep) { result in
            switch result {
            case .success(let repository):
                self.state.value = .loaded(repository)
            case .failure(let error):
                self.state.value = .error(error)
            }
        }
    }
}
