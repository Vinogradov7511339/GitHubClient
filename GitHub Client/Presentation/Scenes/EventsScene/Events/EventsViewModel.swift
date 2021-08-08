//
//  EventsViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

struct EventsActions{}

protocol EventsViewModelInput {}

protocol EventsViewModelOutput {}

typealias EventsViewModel = EventsViewModelInput & EventsViewModelOutput

final class EventsViewModelImpl: EventsViewModel {

    // MARK: - Private

    private let useCase: EventsUseCase
    private let actions: EventsActions

    init(useCase: EventsUseCase, actions: EventsActions) {
        self.useCase = useCase
        self.actions = actions
    }
}
