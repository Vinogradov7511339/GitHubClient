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
