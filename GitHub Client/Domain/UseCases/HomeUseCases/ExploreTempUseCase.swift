//
//  ExploreTempUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import Foundation

protocol ExploreTempUseCase {

    func searchAllTypesByName(_ name: String, completion: @escaping RepositoriesHandler)

    // MARK: - Repositories

    typealias RepositoriesHandler = ExploreTempRepository.RepositoriesHandler
    func mostStarred(completion: @escaping RepositoriesHandler)
    func searchRepositoryByName(_ name: String, completion: @escaping RepositoriesHandler)

    // MARK: - Users
    typealias UsersHandler = ExploreTempRepository.UsersHandler
    func searchUsersByName(_ name: String, completion: @escaping UsersHandler)
}

final class ExploreTempUseCaseImpl {

    private let exploreRepository: ExploreTempRepository

    init(exploreRepository: ExploreTempRepository) {
        self.exploreRepository = exploreRepository
    }
}

// MARK: - ExploreTempUseCase
extension ExploreTempUseCaseImpl: ExploreTempUseCase {
    func mostStarred(completion: @escaping RepositoriesHandler) {
        let text = "stars:>10000"
        let searchModel = SearchRequestModel(searchType: .repositories, searchText: text)
        exploreRepository.fetchRepositories(searchModel, completion: completion)
    }

    func searchAllTypesByName(_ name: String, completion: @escaping RepositoriesHandler) {

    }

    func searchRepositoryByName(_ name: String, completion: @escaping RepositoriesHandler) {
        let text = "\(name) in:name,description"
        let searchModel = SearchRequestModel(searchType: .repositories, searchText: text)
        exploreRepository.fetchRepositories(searchModel, completion: completion)
    }

    func searchUsersByName(_ name: String, completion: @escaping UsersHandler) {
        let text = "\(name) in:name"
        let searchModel = SearchRequestModel(searchType: .users, searchText: text)
        exploreRepository.fetchUsers(searchModel, completion: completion)
    }
}
