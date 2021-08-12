//
//  UsersListRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 12.08.2021.
//

import Foundation

class UsersListRepositoryImpl {
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - UsersListRepository
extension UsersListRepositoryImpl: UsersListRepository {
    func fetch(requestModel: UsersListRequestModel, completion: @escaping (Result<UsersListResponseModel, Error>) -> Void) {
        switch requestModel.listType {
        case .myFollowers:
            let endpoint = MyProfileEndpoinds.getMyFollowers(page: requestModel.page)
            fetch(endpoint: endpoint, completion: completion)
        case .myFollowing:
            let endpoint = MyProfileEndpoinds.getMyFollowing(page: requestModel.page)
            fetch(endpoint: endpoint, completion: completion)
        case .userFollowers(let user):
            let endpoint = UserEndpoints.getFollowers(login: user.login, page: requestModel.page)
            fetch(endpoint: endpoint, completion: completion)
        case .userFollowings(let user):
            let endpoint = UserEndpoints.getFollowing(login: user.login, page: requestModel.page)
            fetch(endpoint: endpoint, completion: completion)
        }
    }
}

// MARK: - Private
private extension UsersListRepositoryImpl {
    func fetch(endpoint: Endpoint<[UserResponseDTO]>,
                    completion: @escaping (Result<UsersListResponseModel, Error>) -> Void) {
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let lastPage = self.tryTakeLastPage(response.httpResponse)
                let model = UsersListResponseModel(
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
