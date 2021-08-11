//
//  HomeViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import UIKit

struct HomeActions {
    let showIssues: () -> Void
    let showPullRequests: () -> Void
    let showDiscussions: () -> Void
    let showOrganizations: () -> Void
    let showFavorites: () -> Void
    let showRepositories: () -> Void
    let showRepository: (Repository) -> Void
    let showRecentEvent: (Event) -> Void
}

protocol HomeViewModelInput {
    func viewWillAppear()
    func refresh()
    func showFavorites()
    func didSelectItem(at indexPath: IndexPath)
}

protocol HomeViewModelOutput {
    var favorites: Observable<[Repository]> { get }
}

typealias HomeViewModel = HomeViewModelInput & HomeViewModelOutput

final class HomeViewModelImpl: HomeViewModel {

    // MARK: - Output

    var favorites: Observable<[Repository]> = Observable([])

    // MARK: - Private

    private let useCase: HomeUseCase
    private let actions: HomeActions

    init(useCase: HomeUseCase, actions: HomeActions) {
        self.useCase = useCase
        self.actions = actions
    }

    static func items() -> [TableCellViewModel] {
        return [
            TableCellViewModel(text: "Issues", detailText: "text2"),
            TableCellViewModel(text: "Pull Requests", detailText: "text2"),
            TableCellViewModel(text: "Discussions", detailText: "text2"),
            TableCellViewModel(text: "Repositories", detailText: "text2"),
            TableCellViewModel(text: "Organizations", detailText: "text2")
        ]
    }
}

extension HomeViewModelImpl {
    func viewWillAppear() {
        useCase.fetchFavorites { result in
            switch result {
            case .success(let favorites):
                self.favorites.value = favorites
            case .failure(let error):
                self.handle(error)
            }
        }
    }

    func refresh() {}

    func didSelectItem(at indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            actions.showIssues()
        case (0, 1):
            actions.showPullRequests()
        case (0, 2):
            actions.showDiscussions()
        case (0, 3):
            actions.showRepositories()
        case (0, 4):
            actions.showOrganizations()
        case (0, 5):
            actions.showRepositories()
        case (1, _):
            let repository = favorites.value[indexPath.row]
            actions.showRepository(repository)
        case (2, _):
            break
//            let issue = recent[indexPath.row]
//            actions.showRecentEvent(issue)
        default:
            break
        }
    }

    func showFavorites() {
        actions.showFavorites()
    }
}

// MARK: - Private
private extension HomeViewModelImpl {
    func handle(_ error: Error) {}
}
