//
//  HomeUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import Foundation

protocol HomeUseCase {
    func fetchWidgets(completion: @escaping(Result<[HomeWidget], Error>) -> Void)
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
        completion(.failure(MapError()))
    }
}
