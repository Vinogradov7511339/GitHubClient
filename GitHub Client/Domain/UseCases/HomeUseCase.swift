//
//  HomeUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import Foundation

protocol HomeUseCase {
    func fetchRecent(completion: @escaping(Result<[Issue], Error>) -> Void)
}

final class HomeUseCaseImpl: HomeUseCase {

    let repository: HomeRepository

    init(repository: HomeRepository) {
        self.repository = repository
    }

    func fetchRecent(completion: @escaping (Result<[Issue], Error>) -> Void) {
        repository.fetchRecent(completion: completion)
    }
}
