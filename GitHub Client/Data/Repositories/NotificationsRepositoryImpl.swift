//
//  NotificationsRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import Foundation

final class NotificationsRepositoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - NotificationsRepository
extension NotificationsRepositoryImpl: NotificationsRepository {
    func fetch(_ request: NotificationsRequestModel, completion: @escaping NotificationsHandler) {
        let endpoint = NotificationsEndpoints.getNotifications(request)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let models = response.model.compactMap { $0.toDomain() }
                let model = ListResponseModel<EventNotification>(models, response: response.httpResponse)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
