//
//  HomeUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import Foundation

protocol HomeUseCase {
    func fetchFavorites(completion: @escaping(Result<[Repository], Error>) -> Void)
    func fetchRecent(completion: @escaping(Result<[IssueResponseDTO], Error>) -> Void)
}

final class HomeUseCaseImpl {

    let repository: HomeRepository
    let favoritesStorage: MyFavoritesStorage

    init(repository: HomeRepository, favoritesStorage: MyFavoritesStorage) {
        self.repository = repository
        self.favoritesStorage = favoritesStorage
    }
}

// MARK: - HomeUseCase
extension HomeUseCaseImpl: HomeUseCase {
    func fetchFavorites(completion: @escaping (Result<[Repository], Error>) -> Void) {
        favoritesStorage.fetchFavorites(completion: completion)
    }

    func fetchRecent(completion: @escaping (Result<[IssueResponseDTO], Error>) -> Void) {
        repository.fetchRecent(completion: completion)
    }
}
