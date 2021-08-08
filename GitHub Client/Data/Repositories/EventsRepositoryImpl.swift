//
//  EventsRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

final class EventsRepositoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - EventsRepository
extension EventsRepositoryImpl: EventsRepository {
    func fetchEvents(requestModel: EventsRequestModel, completion: @escaping (Result<EventsResponseModel, Error>) -> Void) {
    }
}
