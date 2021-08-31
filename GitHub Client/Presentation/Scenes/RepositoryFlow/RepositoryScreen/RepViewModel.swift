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
    var title: Observable<String> = Observable("")

    // MARK: - Private variables

    private let url: URL
    private let repUseCase: RepUseCase
    private let actions: RepActions

    // MARK: - Init

    init(_ url: URL, repUseCase: RepUseCase, actions: RepActions) {
        self.url = url
        self.repUseCase = repUseCase
        self.actions = actions
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
//        actions.showOwner(rep.owner.url)
    }

    func showStargazers() {
//        actions.showStargazers(rep.stargazersUrl)
    }

    func showForks() {
//        actions.showForks(rep.forksUrl)
    }

    func showLicense() {}

    func showSources() {
//        actions.showSources(rep.contentUrl)
    }

    func showCommits() {
//        actions.showCommits(rep.commitsUrl)
    }

    func showBranches() {
//        actions.showBranches(rep.branchesUrl)
    }

    func showIssues() {
//        actions.showIssues(rep.issuesUrl)
    }

    func showPulls() {
//        actions.showPulls(rep.pullsUrl)
    }

    func showReleases() {
//        actions.showReleases(rep.releasesUrl)
    }
}

private extension RepViewModelImpl {
    func fetch() {
        state.value = .loading
        repUseCase.fetchRepository(url) { result in
            switch result {
            case .success(let repository):
                self.state.value = .loaded(repository)
            case .failure(let error):
                self.state.value = .error(error)
            }
        }
    }
}
