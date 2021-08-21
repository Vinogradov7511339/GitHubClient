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
                completion(.success(response.model.mapToAuthotization()))
                print(response)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Users
extension MyProfileRepositoryImpl {
    func fetchFollowers(page: Int, completion: @escaping UsersHandler) {
        let endpoint = MyProfileEndpoinds.followers(page: page)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let followers = response.model.compactMap { $0.toDomain() }
                let page = response.httpResponse?.lastPage ?? 1
                let model = UsersResponseModel(items: followers, lastPage: page)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchFollowing(page: Int, completion: @escaping UsersHandler) {
        let endpoint = MyProfileEndpoinds.following(page: page)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let following = response.model.compactMap { $0.toDomain() }
                let page = response.httpResponse?.lastPage ?? 1
                let model = UsersResponseModel(items: following, lastPage: page)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Repositories
extension MyProfileRepositoryImpl {
    func fetchRepList(page: Int, completion: @escaping RepListHandler) {
        let endpoint = MyProfileEndpoinds.repositories(page: page)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let repositories = response.model.compactMap { $0.toDomain() }
                let page = response.httpResponse?.lastPage ?? 1
                let model = RepListResponseModel(repositories: repositories, lastPage: page)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchStarred(page: Int, completion: @escaping RepListHandler) {
        let endpoint = MyProfileEndpoinds.starredRepositories(page: page)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let starred = response.model.compactMap { $0.toDomain() }
                let page = response.httpResponse?.lastPage ?? 1
                let model = RepListResponseModel(repositories: starred, lastPage: page)
                completion(.success(model))
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
                let model = EventsResponseModel(events: events, lastPage: page)
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
                let model = EventsResponseModel(events: events, lastPage: page)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
