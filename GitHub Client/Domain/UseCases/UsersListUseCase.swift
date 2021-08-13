//
//  UsersListUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 12.08.2021.
//

import Foundation

enum UsersListType {
    case myFollowers
    case myFollowing

    case userFollowers(User)
    case userFollowings(User)

    case stargazers(Repository)
}

struct UsersListRequestModel {
    let page: Int
    let listType: UsersListType
}

struct UsersListResponseModel {
    let items: [User]
    let lastPage: Int
}

protocol UsersListUseCase {
    func fetchUsers(request: UsersListRequestModel,
               completion: @escaping (Result<UsersListResponseModel, Error>) -> Void)
}

final class UsersListUseCaseImpl {

    let repository: UsersListRepository

    init(repository: UsersListRepository) {
        self.repository = repository
    }
}

// MARK: - UserListUseCase
extension UsersListUseCaseImpl: UsersListUseCase {
    func fetchUsers(request: UsersListRequestModel, completion: @escaping (Result<UsersListResponseModel, Error>) -> Void) {
        repository.fetch(requestModel: request, completion: completion)
    }
}
