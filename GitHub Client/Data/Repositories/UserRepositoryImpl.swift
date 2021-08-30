//
//  UserProfileRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

final class UserProfileRepositoryImpl: UserRepository {
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - Users
extension UserProfileRepositoryImpl {
    func fetchFollowers(request: UsersRequestModel, completion: @escaping UsersHandler) {
        let endpoint = UserEndpoints.followers(request)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let followers = response.model.compactMap { $0.toDomain() }
                let page = response.httpResponse?.lastPage ?? 1
                let model = ListResponseModel<User>(items: followers, lastPage: page)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchFollowing(request: UsersRequestModel, completion: @escaping UsersHandler) {
        let endpoint = UserEndpoints.following(request)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let following = response.model.compactMap { $0.toDomain() }
                let page = response.httpResponse?.lastPage ?? 1
                let model = ListResponseModel<User>(items: following, lastPage: page)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - User Profile
extension UserProfileRepositoryImpl {
    func fetchProfile(_ userUrl: URL, completion: @escaping ProfileHandler) {
        let endpoint = UserEndpoints.profile(userUrl)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let model):
                completion(.success(model.model.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - User Repositories
extension UserProfileRepositoryImpl {
    func fetchRepList(request: UsersRequestModel, completion: @escaping RepListHandler) {
        let endpoint = UserEndpoints.repositories(request)
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

    func fetchStarred(request: UsersRequestModel, completion: @escaping RepListHandler) {
        let endpoint = UserEndpoints.starred(request)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let starred = response.model.compactMap { $0.toDomain() }
                let page = response.httpResponse?.lastPage ?? 1
                let model = ListResponseModel<Repository>(items: starred, lastPage: page)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - User Events
extension UserProfileRepositoryImpl {
    func fetchEvents(request: EventsRequestModel, completion: @escaping EventsHandler) {
        fatalError()
    }

    func fetchRecevedtEvents(request: EventsRequestModel, completion: @escaping EventsHandler) {
        fatalError()
    }
}
