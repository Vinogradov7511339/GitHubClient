//
//  HomeViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import UIKit

struct HomeActions {
    let openIssues: () -> Void
}

protocol HomeViewModelInput {
    func viewDidLoad()
    func refresh()

    func openWidget(_ widget: HomeWidget)
}

protocol HomeViewModelOutput {
    var widgetsState: Observable<ItemsSceneState<HomeWidget>> { get }
    var favoritesState: Observable<ItemsSceneState<Repository>> { get }
    var lastEventsState: Observable<ItemsSceneState<Event>> { get }
}

typealias HomeViewModel = HomeViewModelInput & HomeViewModelOutput

final class HomeViewModelImpl: HomeViewModel {

    // MARK: - Output

    var widgetsState: Observable<ItemsSceneState<HomeWidget>> = Observable(.loading)
    var favoritesState: Observable<ItemsSceneState<Repository>> = Observable(.loading)
    var lastEventsState: Observable<ItemsSceneState<Event>> = Observable(.loading)

    // MARK: - Private

    private let useCase: HomeUseCase
    private let actions: HomeActions

    // MARK: - Lifecycle

    init(useCase: HomeUseCase, actions: HomeActions) {
        self.useCase = useCase
        self.actions = actions
    }
}

// MARK: - Input
extension HomeViewModelImpl {
    func viewDidLoad() {
        fetchWidgets()
        fetchFavorites()
        fetchLastEvents()
    }

    func refresh() {
        fetchWidgets()
        fetchFavorites()
        fetchLastEvents()
    }

    func openWidget(_ widget: HomeWidget) {
        switch widget {
        case .issues:
            actions.openIssues()
        default:
            break
        }
    }
}

// MARK: - Private
private extension HomeViewModelImpl {
    func fetchWidgets() {
        widgetsState.value = .loading
        useCase.fetchWidgets { result in
            switch result {
            case .success(let widgets):
                self.widgetsState.value = .loaded(items: widgets, indexPaths: [])
            case .failure(let error):
                self.widgetsState.value = .error(error: error)
            }
        }
    }

    func fetchFavorites() {
        favoritesState.value = .loading
        useCase.fetchFavorites { result in
            switch result {
            case .success(let favorites):
                self.favoritesState.value = .loaded(items: favorites, indexPaths: [])
            case .failure(let error):
                self.favoritesState.value = .error(error: error)
            }
        }
    }

    func fetchLastEvents() {
        lastEventsState.value = .loading
        useCase.fetchEvents { result in
            switch result {
            case .success(let response):
                self.lastEventsState.value = .loaded(items: response.items, indexPaths: [])
            case .failure(let error):
                self.lastEventsState.value = .error(error: error)
            }
        }
    }
}
