//
//  ListRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 31.08.2021.
//

import Foundation

protocol ListRepository {
    typealias UsersHandler = (Result<ListResponseModel<User>, Error>) -> Void
    func fetchUsers(_ requestModel: ListRequestModel, completion: @escaping UsersHandler)

    typealias RepositoriesHandler = (Result<ListResponseModel<Repository>, Error>) -> Void
    func fetchRepositories(_ requestModel: ListRequestModel, completion: @escaping RepositoriesHandler)

    typealias BranchesHandler = (Result<ListResponseModel<Branch>, Error>) -> Void
    func fetchBranches(_ requestModel: ListRequestModel, completion: @escaping BranchesHandler)

    typealias CommitsHandler = (Result<ListResponseModel<Commit>, Error>) -> Void
    func fetchCommits(_ requestModel: ListRequestModel, completion: @escaping CommitsHandler)

    typealias ReleasesHandler = (Result<ListResponseModel<Release>, Error>) -> Void
    func fetchReleases(_ requestModel: ListRequestModel, completion: @escaping ReleasesHandler)

    typealias EventsHandler = (Result<ListResponseModel<Event>, Error>) -> Void
    func fetchEvents(_ requestModel: ListRequestModel, completion: @escaping EventsHandler)
}
