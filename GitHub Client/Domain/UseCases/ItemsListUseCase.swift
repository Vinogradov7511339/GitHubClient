//
//  ItemsListUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import Foundation

enum ListType {
    case pullRequests(Repository)
    case releases(Repository)
}

enum ListEntitiesType {
    case pullRequests([PullRequest])
    case releases([Release])
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
