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
                let lastPage = response.httpResponse?.lastPage ?? 1
                let model = ListResponseModel<EventNotification>(items: models, lastPage: lastPage)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
