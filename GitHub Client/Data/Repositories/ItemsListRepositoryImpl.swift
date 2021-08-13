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

        case .userRepositories(let user):
            let endpoint = UserEndpoints.getRepositories(login: user.login, page: requestModel.page)
            fetchRepositories(endpoint: endpoint, completion: completion)

        case .userStarredRepositories(let user):
            let endpoint = UserEndpoints.getStarredRepositories(login: user.login, page: requestModel.page)
            fetchRepositories(endpoint: endpoint, completion: completion)

        case .stargazers(let repository):
            let endpoint = RepositoryEndpoits.getStargazers(page: requestModel.page, repository: repository)
            fetchUsers(endpoint: endpoint, completion: completion)

        case .forks(let repository):
            let endpoint = RepositoryEndpoits.getForks(page: requestModel.page, repository: repository)
            fetchRepositories(endpoint: endpoint, completion: completion)

        case .issues(let repository):
            let endpoint = RepositoryEndpoits.getIssues(page: requestModel.page, repository: repository)
            fetchIssues(endpoint: endpoint, completion: completion)

        case .pullRequests(let repository):
            let endpoint = RepositoryEndpoits.getPullRequests(page: requestModel.page, repository: repository)
            fetchPullRequests(endpoint: endpoint, completion: completion)

        case .releases(let repository):
            let endpoint = RepositoryEndpoits.getReleases(page: requestModel.page, repository: repository)
            fetchReleases(endpoint: endpoint, completion: completion)

        case .commits(let repository):
            let endpoint = RepositoryEndpoits.getCommits(page: requestModel.page, repository: repository)
            fetchCommits(endpoint: endpoint, completion: completion)
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
                    items: .users(response.model.map { $0.toDomain() }),
                    lastPage: lastPage)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchRepositories(endpoint: Endpoint<[RepositoryResponseDTO]>,
                           completion: @escaping (Result<ItemsListResponseModel, Error>) -> Void) {
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let lastPage = self.tryTakeLastPage(response.httpResponse)
                let model = ItemsListResponseModel(
                    items: .repositories(response.model.map { $0.toDomain() }),
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
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let lastPage = self.tryTakeLastPage(response.httpResponse)
                let model = ItemsListResponseModel(
                    items: .pullRequests(response.model.compactMap { $0.toDomain() }),
                    lastPage: lastPage)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchReleases(endpoint: Endpoint<[ReleaseResponseDTO]>,
                       completion: @escaping (Result<ItemsListResponseModel, Error>) -> Void) {
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let lastPage = self.tryTakeLastPage(response.httpResponse)
                let model = ItemsListResponseModel(
                    items: .releases(response.model.compactMap { $0.toDomain() }),
                    lastPage: lastPage)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchCommits(endpoint: Endpoint<[CommitInfoResponse]>,
                       completion: @escaping (Result<ItemsListResponseModel, Error>) -> Void) {
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let lastPage = self.tryTakeLastPage(response.httpResponse)
                let model = ItemsListResponseModel(
                    items: .commits(response.model.compactMap { $0.toDomain() }),
                    lastPage: lastPage)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
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
