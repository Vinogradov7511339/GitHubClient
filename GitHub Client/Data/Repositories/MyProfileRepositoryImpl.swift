//
//  MyProfileRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import Foundation

final class MyProfileRepositoryImpl {
    private let dataTransferService: DataTransferService
    private let localStorage: ProfileLocalStorage

    init(dataTransferService: DataTransferService, localStorage: ProfileLocalStorage) {
        self.dataTransferService = dataTransferService
        self.localStorage = localStorage
    }
}

// MARK: - MyProfileRepository
extension MyProfileRepositoryImpl: MyProfileRepository {
    func fetch(completion: @escaping (Result<AuthenticatedUser, Error>) -> Void) {
        let endpoint = MyProfileEndpoinds.getMyProfile()
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                completion(.success(response.model.mapToAuthotization()))
                print(response)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchEvents(request: UserEventsRequestModel, completion: @escaping (Result<[Event], Error>) -> Void) {
        let endpoint = UserEndpoints.receivedEvents(login: request.user.login, page: request.page)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                completion(.success(response.model.compactMap { $0.toDomain() }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
