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
    func fetchEvents(requestModel: EventsRequestModel,
                     completion: @escaping (Result<EventsResponseModel, Error>) -> Void) {
        let endpoint = EventEndpoints.getMyEvents(page: requestModel.page)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let events = response.model.compactMap { $0.toDomain() }
                let lastPage = self.tryTakeLastPage(response.httpResponse)
                let responseModel = EventsResponseModel(events: events, lastPage: lastPage)
                completion(.success(responseModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func tryTakeLastPage(_ response: HTTPURLResponse?) -> Int {
        var count = 1
        if let linkBody = response?.allHeaderFields["Link"] as? String {
            if let newCount = linkBody.maxPageCount() {
                count = newCount
            }
        }
        return count
    }
}
