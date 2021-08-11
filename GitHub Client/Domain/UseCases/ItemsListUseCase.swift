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
    case myIssues
    case myPullRequests

    case userFollowers(User)
    case userFollowings(User)
    case userRepositories(User)
    case userStarredRepositories(User)

    case stargazers(Repository)
    case forks(Repository)
    case issues(Repository)
    case pullRequests(Repository)
    case releases(Repository)
    case commits(Repository)
}

enum GitHubEndpoints {
    case myFollowers(page: Int)
    case myFollowing(page: Int)
    case myRepositories(page: Int)
    case myStarredRepositories(page: Int)

    case userFollowers(page: Int, user: User)
    case userFollowings(page: Int, user: User)
    case userRepositories(page: Int, user: User)
    case userStarredRepositories(page: Int, user: User)
}

enum ListEntitiesType {
    case repositories([Repository])
    case users([User])
    case issues([Issue])
    case pullRequests([PullRequest])
    case releases([Release])
    case commits([Commit])
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
