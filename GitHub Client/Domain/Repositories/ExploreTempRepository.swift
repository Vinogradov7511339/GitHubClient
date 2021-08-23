//
//  ExploreTempRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import Foundation

protocol ExploreTempRepository {
    typealias RepositoriesHandler = (Result<SearchResponseModel<Repository>, Error>) -> Void
    func fetchRepositories(_ searchModel: SearchRequestModel, completion: @escaping RepositoriesHandler)

    typealias UsersHandler = (Result<SearchResponseModel<User>, Error>) -> Void
    func fetchUsers(_ searchModel: SearchRequestModel, completion: @escaping UsersHandler)

    typealias IssuesHandler = (Result<SearchResponseModel<Issue>, Error>) -> Void
    func fetchIssues(_ searchModel: SearchRequestModel, completion: @escaping IssuesHandler)
}
