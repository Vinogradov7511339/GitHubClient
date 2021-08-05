//
//  ItemsListUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import Foundation

enum ListType {
    case myFollowers
    case myFollowing
    case myRepositories
    case myStarredRepositories

    case userFollowers(User)
    case userFollowings(User)
    case userRepositories(User)
    case userStarredRepositories(User)
}

enum ListEntitiesType {
    case repositories([Repository])
    case users([User])
}

struct ItemsListRequestModel {
    let page: Int
    let listType: ListType
}

struct ItemsListResponseModel {
    let items: ListEntitiesType
    let lastPage: Int
}

protocol ItemsListUseCase {
    func fetch(request: ItemsListRequestModel,
               completion: @escaping (Result<ItemsListResponseModel, Error>) -> Void)
}

final class ItemsListUseCaseImpl: ItemsListUseCase {

    let repository: ItemsListRepository

    init(repository: ItemsListRepository) {
        self.repository = repository
    }
    
    func fetch(request: ItemsListRequestModel, completion: @escaping (Result<ItemsListResponseModel, Error>) -> Void) {
        repository.fetch(requestModel: request, completion: completion)
    }
}
