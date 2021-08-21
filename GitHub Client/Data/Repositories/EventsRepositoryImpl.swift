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
    func fetchEvents(request: EventsRequestModel, completion: @escaping EventsHandler) {
        let endpoint = EventEndpoints.events(request)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let events = response.model.compactMap { $0.toDomain() }
                let page = response.httpResponse?.lastPage ?? 1
                let model = EventsResponseModel(events: events, lastPage: page)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
