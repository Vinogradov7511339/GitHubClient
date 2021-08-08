//
//  ItemsListRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import Foundation

class ItemsListRepositoryImpl {
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - ItemsListRepository
extension ItemsListRepositoryImpl: ItemsListRepository {
    func fetch(requestModel: ItemsListRequestModel,
               completion: @escaping (Result<ItemsListResponseModel, Error>) -> Void) {
        switch requestModel.listType {
        case .myFollowers:
            let endpoint = MyProfileEndpoinds.getMyFollowers(page: requestModel.page)
            fetchUsers(endpoint: endpoint, completion: completion)

        case .myFollowing:
            let endpoint = MyProfileEndpoinds.getMyFollowing(page: requestModel.page)
            fetchUsers(endpoint: endpoint, completion: completion)

        case .myRepositories:
            let endpoint = MyProfileEndpoinds.getMyRepositories(page: requestModel.page)
            fetchRepositories(endpoint: endpoint, completion: completion)

        case .myStarredRepositories:
            let endpoint = MyProfileEndpoinds.getMyStarredRepositories(page: requestModel.page)
            fetchRepositories(endpoint: endpoint, completion: completion)

        case .myIssues:
            let endpoint = MyProfileEndpoinds.getMyIssues(page: requestModel.page)
            fetchIssues(endpoint: endpoint, completion: completion)

        case .myPullRequests:
            let endpoint = MyProfileEndpoinds.getMyPullRequests(page: requestModel.page)
            fetchPullRequests(endpoint: endpoint, completion: completion)

        case .userFollowers(let user):
            let endpoint = UserEndpoints.getFollowers(login: user.login, page: requestModel.page)
            fetchUsers(endpoint: endpoint, completion: completion)

        case .userFollowings(let user):
            let endpoint = UserEndpoints.getFollowing(login: user.login, page: requestModel.page)
            fetchUsers(endpoint: endpoint, completion: completion)

        case .userRepositories(let user):
            let endpoint = UserEndpoints.getRepositories(login: user.login, page: requestModel.page)
            fetchRepositories(endpoint: endpoint, completion: completion)

        case .userStarredRepositories(let user):
            let endpoint = UserEndpoints.getStarredRepositories(login: user.login, page: requestModel.page)
            fetchRepositories(endpoint: endpoint, completion: completion)
        }
    }
}

private extension ItemsListRepositoryImpl {
    func fetchUsers(endpoint: Endpoint<[UserResponseDTO]>,
                    completion: @escaping (Result<ItemsListResponseModel, Error>) -> Void) {
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let lastPage = self.tryTakeLastPage(response.httpResponse)
                let model = ItemsListResponseModel(
                    items: .users(response.model.map { $0.map() }),
                    lastPage: lastPage)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchRepositories(endpoint: Endpoint<[RepositoryResponse]>,
                           completion: @escaping (Result<ItemsListResponseModel, Error>) -> Void) {
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let lastPage = self.tryTakeLastPage(response.httpResponse)
                let model = ItemsListResponseModel(
                    items: .repositories(response.model.map { $0.map() }),
                    lastPage: lastPage)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchIssues(endpoint: Endpoint<[IssueResponseDTO]>,
                     completion: @escaping (Result<ItemsListResponseModel, Error>) -> Void) {
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let lastPage = self.tryTakeLastPage(response.httpResponse)
                let model = ItemsListResponseModel(
                    items: .issues(response.model.compactMap { $0.toDomain() }),
                    lastPage: lastPage)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchPullRequests(endpoint: Endpoint<[PullRequestResponseDTO]>,
                     completion: @escaping (Result<ItemsListResponseModel, Error>) -> Void) {
        completion(.success(.init(items: .pullRequests([]), lastPage: 1)))
//        dataTransferService.request(with: endpoint) { result in
//            switch result {
//            case .success(let response):
//                let lastPage = self.tryTakeLastPage(response.httpResponse)
//                let model = ItemsListResponseModel(
//                    items: .pullRequests(response.model.compactMap { $0.toDomain() }),
//                    lastPage: lastPage)
//                completion(.success(model))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
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
