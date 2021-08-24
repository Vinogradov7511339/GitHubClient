//
//  ExploreTempRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import Foundation

final class ExploreTempRepositoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - ExploreTempRepository
extension ExploreTempRepositoryImpl: ExploreTempRepository {
    func fetchRepositories(_ searchModel: SearchRequestModel, completion: @escaping RepositoriesHandler) {
        let endpoint = ExploreTempEndpoints.repositories(searchModel)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let repositories = response.model.items.compactMap { $0.toDomain() }
                let lastPage = response.httpResponse?.lastPage ?? 1
                let total = response.model.totalCount
                let model = SearchResponseModel(itemsType: .repository(repositories),
                                                            lastPage: lastPage,
                                                            total: total)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchIssues(_ searchModel: SearchRequestModel, completion: @escaping IssuesHandler) {
        let endpoint = ExploreTempEndpoints.issues(searchModel)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let issues = response.model.items.compactMap { $0.toDomain() }
                let lastPage = response.httpResponse?.lastPage ?? 1
                let total = response.model.totalCount
                let model = SearchResponseModel(itemsType: .issue(issues),
                                                      lastPage: lastPage,
                                                      total: total)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchPullRequests(_ searchModel: SearchRequestModel, completion: @escaping PullRequestsHandler) {
        let endpoint = ExploreTempEndpoints.pullRequests(searchModel)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let pullRequests = response.model.items.compactMap { $0.toDomain() }
                let lastPage = response.httpResponse?.lastPage ?? 1
                let total = response.model.totalCount
                let model = SearchResponseModel(itemsType: .pullRequest(pullRequests),
                                                      lastPage: lastPage,
                                                      total: total)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchUsers(_ searchModel: SearchRequestModel, completion: @escaping UsersHandler) {
        let endpoint = ExploreTempEndpoints.users(searchModel)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let users = response.model.items.compactMap { $0.toDomain() }
                let lastPage = response.httpResponse?.lastPage ?? 1
                let total = response.model.totalCount
                let model = SearchResponseModel(itemsType: .users(users),
                                                      lastPage: lastPage,
                                                      total: total)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
