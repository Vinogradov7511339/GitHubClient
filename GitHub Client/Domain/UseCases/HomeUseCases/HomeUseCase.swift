//
//  HomeUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import Foundation

protocol HomeUseCase {
    func fetchWidgets(completion: @escaping(Result<[HomeWidget], Error>) -> Void)
    func fetchFavorites(completion: @escaping(Result<[Repository], Error>) -> Void)
    func fetchEvents(completion: @escaping(Result<[Event], Error>) -> Void)
}

final class HomeUseCaseImpl {

    let repository: MyProfileRepository

    init(repository: MyProfileRepository) {
        self.repository = repository
    }
}

// MARK: - HomeUseCase
extension HomeUseCaseImpl: HomeUseCase {
    func fetchWidgets(completion: @escaping (Result<[HomeWidget], Error>) -> Void) {
        repository.fetchWidgets(completion: completion)
    }

    func fetchFavorites(completion: @escaping (Result<[Repository], Error>) -> Void) {
        completion(.success([]))
    }

    func fetchEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        completion(.success([]))
    }
}
