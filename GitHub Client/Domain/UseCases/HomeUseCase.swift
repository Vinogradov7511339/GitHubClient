//
//  HomeUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import Foundation

protocol HomeUseCase {
    func addFavorite(repository: Repository, completion: @escaping (Error?) -> Void)
    func removeFavorite(by repositoryId: Int, completion: @escaping (Error?) -> Void)
    func fetchFavorites(completion: @escaping(Result<[Repository], Error>) -> Void)
    func fetchRepositories(completion: @escaping (Result<[Repository], Error>) -> Void)
    func fetchRecent(completion: @escaping(Result<[IssueResponseDTO], Error>) -> Void)
}

final class HomeUseCaseImpl {

    let repository: HomeRepository
    let favoritesStorage: FavoritesStorage

    init(repository: HomeRepository, favoritesStorage: FavoritesStorage) {
        self.repository = repository
        self.favoritesStorage = favoritesStorage
    }
}

// MARK: - HomeUseCase
extension HomeUseCaseImpl: HomeUseCase {
    func fetchRepositories(completion: @escaping (Result<[Repository], Error>) -> Void) {
        repository.fetchRepositories(completion: completion)
    }

    func fetchFavorites(completion: @escaping (Result<[Repository], Error>) -> Void) {
        favoritesStorage.fetchFavorites(completion: completion)
    }

    func fetchRecent(completion: @escaping (Result<[IssueResponseDTO], Error>) -> Void) {
        repository.fetchRecent(completion: completion)
    }

    func addFavorite(repository: Repository, completion: @escaping (Error?) -> Void) {
        favoritesStorage.addFavorite(repository: repository, completion: completion)
    }

    func removeFavorite(by repositoryId: Int, completion: @escaping (Error?) -> Void) {
        favoritesStorage.removeFavorite(by: repositoryId, completion: completion)
    }
}
