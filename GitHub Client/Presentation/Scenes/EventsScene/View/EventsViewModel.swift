//
//  EventsViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

struct EventsActions {}

protocol EventsViewModelInput {
    func viewDidLoad()
    func apply(filters: [EventFilterType])
    func refresh()
}

protocol EventsViewModelOutput {
    var events: Observable<[Event]> { get }
}

typealias EventsViewModel = EventsViewModelInput & EventsViewModelOutput

final class EventsViewModelImpl: EventsViewModel {

    // MARK: - Output
    var events: Observable<[Event]> = Observable([])

    // MARK: - Private

    private let useCase: EventsUseCase
    private let actions: EventsActions

    private var currentPage = 1
    private var lastPage: Int?

    init(useCase: EventsUseCase, actions: EventsActions) {
        self.useCase = useCase
        self.actions = actions
    }
}

// MARK: - Input
extension EventsViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func apply(filters: [EventFilterType]) {
//        events.value = events.value.filter { $0.eventType == .pushEvent }
    }

    func refresh() {
        fetch()
    }
}

private extension EventsViewModelImpl {
    func fetch() {}

    func handle(error: Error) {}
}
