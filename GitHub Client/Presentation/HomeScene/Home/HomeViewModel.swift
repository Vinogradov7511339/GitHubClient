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
    let showRecentEvent: (Issue) -> Void
}

protocol HomeViewModelInput {
    func viewDidLoad()
    func refresh()
    func didSelectItem(at indexPath: IndexPath)
}

protocol HomeViewModelOutput {
    var cellManager: TableCellManager { get }
    var tableItems: Observable<[[Any]]> { get }
}

typealias HomeViewModel = HomeViewModelInput & HomeViewModelOutput

final class HomeViewModelImpl: HomeViewModel {

    // MARK: - Output

    let cellManager: TableCellManager
    let tableItems: Observable<[[Any]]> = Observable(ProfileViewModelImpl.items())

    // MARK: - Private

    private let useCase: HomeUseCase
    private let actions: HomeActions
    private var favorites: [Repository] = []
    private var recent: [Issue] = []

    init(useCase: HomeUseCase, actions: HomeActions) {
        self.useCase = useCase
        self.actions = actions
        cellManager = TableCellManager.create(cellType: IssueTableViewCell.self)
    }
}

extension HomeViewModelImpl {
    func viewDidLoad() {
        useCase.fetchRecent { result in
        }
    }
    func refresh() {
        useCase.fetchRecent { result in
        }
    }

    func didSelectItem(at indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 1):
            actions.showIssues()
        case (0, 2):
            actions.showPullRequests()
        case (0, 3):
            actions.showDiscussions()
        case (0, 4):
            actions.showRepositories()
        case (1, _):
            let repository = favorites[indexPath.row]
            actions.showRepository(repository)
        case (2, _):
            let issue = recent[indexPath.row]
            actions.showRecentEvent(issue)
        default:
            break
        }
    }
}
