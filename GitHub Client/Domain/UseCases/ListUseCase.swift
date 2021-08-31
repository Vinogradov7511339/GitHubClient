//
//  ListUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 31.08.2021.
//

import Foundation

protocol ListUseCase {
    typealias UsersHandler = ListRepository.UsersHandler
    func fetchUsers(_ requestModel: ListRequestModel, completion: @escaping UsersHandler)

    typealias RepositoriesHandler = ListRepository.RepositoriesHandler
    func fetchRepositories(_ requestModel: ListRequestModel, completion: @escaping RepositoriesHandler)

    typealias BranchesHandler = ListRepository.BranchesHandler
    func fetchBranches(_ requestModel: ListRequestModel, completion: @escaping BranchesHandler)

    typealias CommitsHandler = ListRepository.CommitsHandler
    func fetchCommits(_ requestModel: ListRequestModel, completion: @escaping CommitsHandler)

    typealias ReleasesHandler = ListRepository.ReleasesHandler
    func fetchReleases(_ requestModel: ListRequestModel, completion: @escaping ReleasesHandler)
}

final class ListUseCaseImpl {
    let repository: ListRepository

    init(repository: ListRepository) {
        self.repository = repository
    }
}

// MARK: - ListUseCase
extension ListUseCaseImpl: ListUseCase {
    func fetchUsers(_ requestModel: ListRequestModel, completion: @escaping UsersHandler) {
        repository.fetchUsers(requestModel, completion: completion)
    }

    func fetchRepositories(_ requestModel: ListRequestModel, completion: @escaping RepositoriesHandler) {
        repository.fetchRepositories(requestModel, completion: completion)
    }

    func fetchBranches(_ requestModel: ListRequestModel, completion: @escaping BranchesHandler) {
        repository.fetchBranches(requestModel, completion: completion)
    }

    func fetchCommits(_ requestModel: ListRequestModel, completion: @escaping CommitsHandler) {
        repository.fetchCommits(requestModel, completion: completion)
    }

    func fetchReleases(_ requestModel: ListRequestModel, completion: @escaping ReleasesHandler) {
        repository.fetchReleases(requestModel, completion: completion)
    }
}
