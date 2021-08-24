//
//  ExploreTempRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import Foundation

protocol ExploreTempRepository {
    typealias RepositoriesHandler = (Result<SearchResponseModel, Error>) -> Void
    func fetchRepositories(_ searchModel: SearchRequestModel, completion: @escaping RepositoriesHandler)

    typealias IssuesHandler = (Result<SearchResponseModel, Error>) -> Void
    func fetchIssues(_ searchModel: SearchRequestModel, completion: @escaping IssuesHandler)

    typealias PullRequestsHandler = (Result<SearchResponseModel, Error>) -> Void
    func fetchPullRequests(_ searchModel: SearchRequestModel, completion: @escaping PullRequestsHandler)

    typealias UsersHandler = (Result<SearchResponseModel, Error>) -> Void
    func fetchUsers(_ searchModel: SearchRequestModel, completion: @escaping UsersHandler)
}
