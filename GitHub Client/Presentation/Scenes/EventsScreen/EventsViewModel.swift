//
//  EventsViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 01.09.2021.
//

import UIKit

struct EventsActions {}

protocol EventsViewModelInput {
    func viewDidLoad()
    func refresh()
}

protocol EventsViewModelOutput {
    var state: Observable<ItemsSceneState<Event>> { get }
}

typealias EventsViewModel = EventsViewModelInput & EventsViewModelOutput

enum EventsType {
    case events(URL)
    case recentEvents(URL)

    var url: URL {
        switch self {
        case .events(let url):
            return url
        case .recentEvents(let url):
            return url
        }
    }
}

final class EventsViewModelImpl: EventsViewModel {

    // MARK: - Output

    var state: Observable<ItemsSceneState<Event>> = Observable(.loading)

    // MARK: - Private variables

    private let type: EventsType
    private let useCase: ListUseCase
    private let actions: EventsActions
    private var currentPage = 1
    private var lastPage = 1

    // MARK: - Lifecycle

    init(_ type: EventsType, usecase: ListUseCase, actions: EventsActions) {
        self.type = type
        self.useCase = usecase
        self.actions = actions
    }
}

// MARK: - Input
extension EventsViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func refresh() {
        fetch()
    }
}

private extension EventsViewModelImpl {
    func fetch() {
        state.value = .loading
        switch type {
        case .events(let url), .recentEvents(let url):
            let model = ListRequestModel(path: url, page: currentPage)
            useCase.fetchEvents(model, completion: handler)
        }
    }

    func handler(_ result: Result<ListResponseModel<Event>, Error>) {
        switch result {
        case .success(let responseModel):
            self.lastPage = responseModel.lastPage
            self.state.value = .loaded(items: responseModel.items, indexPaths: [])
        case .failure(let error):
            self.state.value = .error(error: error)
        }
    }
}
