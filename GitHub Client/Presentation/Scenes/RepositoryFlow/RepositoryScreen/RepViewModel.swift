//
//  RepViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

struct RepActions {
    let share: (URL) -> Void

    let showOwner: (URL) -> Void

    let showForks: (URL) -> Void
    let showStargazers: (URL) -> Void
    let showSubscribers: (URL) -> Void
    let showContributors: (URL) -> Void

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

    func share()

    func showOwner()

    func showForks()
    func showStargazers()
    func showSubscribers()
    func showContributors()

    func showLicense()

    func showSources()
    func showCommits()
    func showBranches()
    func showIssues()
    func showPulls()
    func showReleases()
}

protocol RepViewModelOutput {
    var title: Observable<String> { get }
    var state: Observable<DetailsScreenState<RepositoryDetails>> { get }
}

typealias RepViewModel = RepViewModelInput & RepViewModelOutput

final class RepViewModelImpl: RepViewModel {

    // MARK: - OUTPUT

    let state: Observable<DetailsScreenState<RepositoryDetails>> = Observable(.loading)
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

    func share() {
        guard case .loaded(let rep) = state.value else { return }
        actions.share(rep.repository.htmlUrl)
    }

    func showOwner() {
        guard case .loaded(let rep) = state.value else { return }
        actions.showOwner(rep.repository.owner.url)
    }

    func showForks() {
        guard case .loaded(let rep) = state.value else { return }
        actions.showForks(rep.repository.forksUrl)
    }

    func showStargazers() {
        guard case .loaded(let rep) = state.value else { return }
        actions.showStargazers(rep.repository.stargazersUrl)
    }

    func showSubscribers() {
        guard case .loaded(let rep) = state.value else { return }
        actions.showSubscribers(rep.repository.subscribersUrl)
    }

    func showContributors() {
        guard case .loaded(let rep) = state.value else { return }
        actions.showContributors(rep.repository.contributorsUrl)
    }

    func showLicense() {}

    func showSources() {
        guard case .loaded(let rep) = state.value else { return }
        actions.showSources(rep.repository.contentUrl)
    }

    func showCommits() {
        guard case .loaded(let rep) = state.value else { return }
        actions.showCommits(rep.repository.commitsUrl)
    }

    func showBranches() {
        guard case .loaded(let rep) = state.value else { return }
        actions.showBranches(rep.repository.branchesUrl)
    }

    func showIssues() {
        guard case .loaded(let rep) = state.value else { return }
        actions.showIssues(rep.repository.issuesUrl)
    }

    func showPulls() {
        guard case .loaded(let rep) = state.value else { return }
        actions.showPulls(rep.repository.pullsUrl)
    }

    func showReleases() {
        guard case .loaded(let rep) = state.value else { return }
        actions.showReleases(rep.repository.releasesUrl)
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
