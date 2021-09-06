//
//  HomeViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import UIKit

struct HomeActions {}

protocol HomeViewModelInput {
    func viewDidLoad()
    func refresh()
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
}

// MARK: - Private
private extension HomeViewModelImpl {
    func fetchWidgets() {
        widgetsState.value = .loading
        useCase.fetchWidgets { result in
            switch result {
            case .success(let widgets):
                self.widgetsState.value = .loaded(items: widgets)
            case .failure(let error):
                self.widgetsState.value = .error(error: error)
            }
        }
    }

    func fetchFavorites() {
        favoritesState.value = .loading
    }

    func fetchLastEvents() {
        lastEventsState.value = .loading
    }
}
