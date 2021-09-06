//
//  MyProfileRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import Foundation

final class MyProfileRepositoryImpl: MyProfileRepository {

    private let dataTransferService: DataTransferService
    private let localStorage: ProfileLocalStorage

    init(dataTransferService: DataTransferService, localStorage: ProfileLocalStorage) {
        self.dataTransferService = dataTransferService
        self.localStorage = localStorage
    }
}

// MARK: - Profile
extension MyProfileRepositoryImpl {
    func fetchProfile(completion: @escaping ProfileHandler) {
        let endpoint = MyProfileEndpoinds.profile()
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                if let user = response.model.mapToAuthotization() {
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

// MARK: - Events
extension MyProfileRepositoryImpl {
    func fetchRecevedEvents(request: EventsRequestModel, completion: @escaping EventsHandler) {
        let endpoint = MyProfileEndpoinds.receivedEvents(request)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let events = response.model.compactMap { $0.toDomain() }
                let page = response.httpResponse?.lastPage ?? 1
                let model = ListResponseModel<Event>(items: events, lastPage: page)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchEvents(request: EventsRequestModel, completion: @escaping EventsHandler) {
        let endpoint = MyProfileEndpoinds.events(request)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let events = response.model.compactMap { $0.toDomain() }
                let page = response.httpResponse?.lastPage ?? 1
                let model = ListResponseModel<Event>(items: events, lastPage: page)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Subscriptions
extension MyProfileRepositoryImpl {
    func fetchSubscriptions(page: Int, completion: @escaping SubscriptionsHandler) {
        let endpoint = MyProfileEndpoinds.subscriptions(page: page)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let repositories = response.model.compactMap { $0.toDomain() }
                let page = response.httpResponse?.lastPage ?? 1
                let model = ListResponseModel<Repository>(items: repositories, lastPage: page)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension MyProfileRepositoryImpl {
    func fetchWidgets(completion: @escaping WidgetsHandler) {
        let widgets: [HomeWidget] = [.issues, .repositories, .starredRepositories]
        completion(.success(widgets))
    }
}
