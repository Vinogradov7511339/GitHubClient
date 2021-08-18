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
    func fetch(completion: @escaping (Result<[EventNotification], Error>) -> Void) {
        let endpoint = NotificationsEndpoints.getNotifications()
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let models = response.model.compactMap { $0.toDomain() }
                completion(.success(models))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
