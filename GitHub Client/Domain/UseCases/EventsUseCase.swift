//
//  EventsUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

struct EventsRequestModel {

}

struct EventsResponseModel {

}

protocol EventsUseCase {
    func fetchEvents(requestModel: EventsRequestModel, completion: @escaping (Result<EventsResponseModel, Error>) -> Void)
}

final class EventsUseCaseImpl {

    private let repository: EventsRepository

    init(repository: EventsRepository) {
        self.repository = repository
    }
}

// MARK: - EventsUseCase
extension EventsUseCaseImpl: EventsUseCase {
    func fetchEvents(requestModel: EventsRequestModel, completion: @escaping (Result<EventsResponseModel, Error>) -> Void) {
        repository.fetchEvents(requestModel: requestModel, completion: completion)
    }
}
