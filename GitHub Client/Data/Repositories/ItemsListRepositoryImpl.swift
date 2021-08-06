//
//  ItemsListRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import Foundation
import Networking

struct GitHubAPIError: Error {}

class ItemsListRepositoryImpl: ItemsListRepository {

    private let service = NetworkService()

    func fetch(requestModel: ItemsListRequestModel,
               completion: @escaping (Result<ItemsListResponseModel, Error>) -> Void) {
        let endpoint: GitHubEndpoints
        switch requestModel.listType {
        case .myFollowers:
            endpoint = .myFollowers(page: requestModel.page)
            fetchUsers(endpoint: endpoint, completion: completion)

        case .myFollowing:
            endpoint = .myFollowing(page: requestModel.page)
            fetchUsers(endpoint: endpoint, completion: completion)

        case .myRepositories:
            endpoint = .myRepositories(page: requestModel.page)
            fetchRepositories(endpoint: endpoint, completion: completion)

        case .myStarredRepositories:
            endpoint = .myStarredRepositories(page: requestModel.page)
            fetchRepositories(endpoint: endpoint, completion: completion)

        case .userFollowers(let user):
            endpoint = .userFollowers(page: requestModel.page, user: user)
            fetchUsers(endpoint: endpoint, completion: completion)

        case .userFollowings(let user):
            endpoint = .userFollowings(page: requestModel.page, user: user)
            fetchUsers(endpoint: endpoint, completion: completion)

        case .userRepositories(let user):
            endpoint = .userRepositories(page: requestModel.page, user: user)
            fetchRepositories(endpoint: endpoint, completion: completion)

        case .userStarredRepositories(let user):
            endpoint = .userStarredRepositories(page: requestModel.page, user: user)
            fetchRepositories(endpoint: endpoint, completion: completion)
        }
    }

    func fetchUsers(endpoint: GitHubEndpoints, completion: @escaping (Result<ItemsListResponseModel, Error>) -> Void) {
        service.request(endpoint) { data, response, error in
            guard let httpRespoonse = response as? HTTPURLResponse else {
                completion(.failure(GitHubAPIError()))
                return
            }

            guard let linkBody = httpRespoonse.allHeaderFields["Link"] as? String else {
                completion(.failure(GitHubAPIError()))
                return
            }

            guard let count = linkBody.maxPageCount() else {
                completion(.failure(GitHubAPIError()))
                return
            }
            guard let data = data else {
                completion(.failure(GitHubAPIError()))
                return
            }
            guard let models = self.service.decode(of: [UserResponseDTO].self, from: data) else {
                completion(.failure(GitHubAPIError()))
                return
            }
            let mapped = models.map { $0.map() }
            let responseModel = ItemsListResponseModel(items: .users(mapped), lastPage: count)
            completion(.success(responseModel))
        }
    }
    
    func fetchRepositories(endpoint: GitHubEndpoints, completion: @escaping (Result<ItemsListResponseModel, Error>) -> Void) {
        service.request(endpoint) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(GitHubAPIError()))
                return
            }

            var count = 1
            if let linkBody = httpResponse.allHeaderFields["Link"] as? String {
                if let newCount = linkBody.maxPageCount() {
                    count = newCount
                }
            }

            guard let data = data else {
                completion(.failure(GitHubAPIError()))
                return
            }
            guard let models = self.service.decode(of: [RepositoryResponse].self, from: data) else {
                completion(.failure(GitHubAPIError()))
                return
            }
            let mapped = models.map { $0.map() }
            let responseModel = ItemsListResponseModel(items: .repositories(mapped), lastPage: count)
            completion(.success(responseModel))
        }
    }
}
