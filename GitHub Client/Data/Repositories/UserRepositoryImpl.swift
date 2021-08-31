//
//  UserProfileRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

struct MapError: Error {}

final class UserProfileRepositoryImpl: UserRepository {
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - User Profile
extension UserProfileRepositoryImpl {
    func fetchProfile(_ userUrl: URL, completion: @escaping ProfileHandler) {
        let endpoint = UserEndpoints.profile(userUrl)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let model):
                if let user = model.model.toDomain() {
                    completion(.success(user))
                } else {
                    let error = MapError()
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - User Events
extension UserProfileRepositoryImpl {
    func fetchEvents(request: EventsRequestModel, completion: @escaping EventsHandler) {
        let endpoint = MyProfileEndpoinds.events(request)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let items = response.model.map { $0.toDomain() }
                let lastPage = response.httpResponse?.lastPage ?? 1
                let model = ListResponseModel<Event>(items: items, lastPage: lastPage)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchRecevedtEvents(request: EventsRequestModel, completion: @escaping EventsHandler) {
        let endpoint = MyProfileEndpoinds.receivedEvents(request)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let items = response.model.map { $0.toDomain() }
                let lastPage = response.httpResponse?.lastPage ?? 1
                let model = ListResponseModel<Event>(items: items, lastPage: lastPage)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
