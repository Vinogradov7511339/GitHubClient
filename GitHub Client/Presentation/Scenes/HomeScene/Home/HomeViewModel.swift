//
//  HomeViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import UIKit

struct HomeActions {
    let showIssues: () -> Void
    let showDiscussions: () -> Void
    let showOrganizations: () -> Void
    let showFavorites: () -> Void
    let showRepositories: () -> Void
    let showRepository: (Repository) -> Void
    let showRecentEvent: (Event) -> Void
}

protocol HomeViewModelInput {
    func viewDidLoad()
    func refresh()
    func showFavorites()
    func didSelectItem(at indexPath: IndexPath)
}

protocol HomeViewModelOutput {
    var favorites: Observable<[Repository]> { get }
    var widgets: Observable<[HomeWidget]> { get }
}

typealias HomeViewModel = HomeViewModelInput & HomeViewModelOutput

final class HomeViewModelImpl: HomeViewModel {

    // MARK: - Output

    var favorites: Observable<[Repository]> = Observable([])
    var widgets: Observable<[HomeWidget]> = Observable([])

    // MARK: - Private

    private let useCase: HomeUseCase
    private let actions: HomeActions

    init(useCase: HomeUseCase, actions: HomeActions) {
        self.useCase = useCase
        self.actions = actions
    }
}

extension HomeViewModelImpl {
    func viewDidLoad() {
        useCase.fetchWidgets { result in
            switch result {
            case .success(let widgets):
                self.widgets.value = widgets
            case .failure(let error):
                self.handle(error)
            }
        }
    }

    func refresh() {}

    func didSelectItem(at indexPath: IndexPath) {
        let widget = widgets.value[indexPath.row]
        openWidget(widget)
    }

    func showFavorites() {
        actions.showFavorites()
    }
}

// MARK: - Private
private extension HomeViewModelImpl {
    func handle(_ error: Error) {}

    func openWidget(_ widget: HomeWidget) {
        switch widget {
        case .issues:
            actions.showIssues()
        }
    }
}
