//
//  RepositoriesRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import Foundation

class RepositoriesRepositoryImpl {
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - RepositoriesRepository
extension RepositoriesRepositoryImpl: RepositoriesRepository {
    func fetch(requestModel: RepositoriesRequestModel, completion: @escaping (Result<RepositoriesResponseModel, Error>) -> Void) {
        switch requestModel.listType {
        case .myRepositories:
            let endpoint = MyProfileEndpoinds.getMyRepositories(page: requestModel.page)
            fetch(endpoint: endpoint, completion: completion)
        case .myStarred:
            let endpoint = MyProfileEndpoinds.getMyStarredRepositories(page: requestModel.page)
            fetch(endpoint: endpoint, completion: completion)
        case .userRepositories(let user):
            let endpoint = UserEndpoints.getRepositories(login: user.login, page: requestModel.page)
            fetch(endpoint: endpoint, completion: completion)
        case .userStarred(let user):
            let endpoint = UserEndpoints.getStarredRepositories(login: user.login, page: requestModel.page)
            fetch(endpoint: endpoint, completion: completion)
        }
    }
}

// MARK: - Private
private extension RepositoriesRepositoryImpl {
    func fetch(endpoint: Endpoint<[RepositoryResponseDTO]>,
                           completion: @escaping (Result<RepositoriesResponseModel, Error>) -> Void) {
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let lastPage = self.tryTakeLastPage(response.httpResponse)
                let model = RepositoriesResponseModel(
                    items: response.model.map { $0.toDomain() },
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
