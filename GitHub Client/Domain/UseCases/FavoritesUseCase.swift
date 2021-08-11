//
//  FavoritesUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 11.08.2021.
//

import Foundation

protocol FavoritesUseCase {
    typealias Favorites = (favorites: [Repository], notFavorites: [Repository])

    func fetchRepositories(completion: @escaping (Result<Favorites, Error>) -> Void)
}

final class FavoritesUseCaseImpl {

    let repository: HomeRepository
    let favoritesStorage: FavoritesStorage

    init(repository: HomeRepository, favoritesStorage: FavoritesStorage) {
        self.repository = repository
        self.favoritesStorage = favoritesStorage
    }
}

// MARK: - FavoritesUseCase
extension FavoritesUseCaseImpl: FavoritesUseCase {
    func fetchRepositories(completion: @escaping (Result<Favorites, Error>) -> Void) {
        repository.fetchRepositories { result in
            switch result {
            case .success(let repositories):
                self.filter(repositories, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Private
private extension FavoritesUseCaseImpl {
    func filter(_ repositories: [Repository], completion: @escaping (Result<Favorites, Error>) -> Void) {
        var favorites: [Repository] = []
        var notFavorites: [Repository] = []

        for repository in repositories {
            if favoritesStorage.contains(repository.repositoryId) {
                favorites.append(repository)
            } else {
                notFavorites.append(repository)
            }
        }

        let result = Favorites(favorites: favorites, notFavorites: notFavorites)
        completion(.success(result))
    }
}
