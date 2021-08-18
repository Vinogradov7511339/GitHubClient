//
//  EventsUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

protocol EventsUseCase {
    typealias EventsHandler = (Result<EventsResponseModel, Error>) -> Void

    func fetchEvents(requestModel: EventsRequestModel, completion: @escaping EventsHandler)
}

final class EventsUseCaseImpl {

    private let repository: EventsRepository

    init(repository: EventsRepository) {
        self.repository = repository
    }
}

// MARK: - EventsUseCase
extension EventsUseCaseImpl: EventsUseCase {
    func fetchEvents(requestModel: EventsRequestModel, completion: @escaping EventsHandler) {
        repository.fetchEvents(requestModel: requestModel, completion: completion)
    }
}
