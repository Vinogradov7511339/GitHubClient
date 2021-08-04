//
//  StarredUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

protocol StarredUseCase {
    func fetch(page: Int, completion: @escaping (Result<[Repository], Error>) -> Void)
}

final class StarredUseCaseImpl: StarredUseCase {
    
    let login: String
    let repository: StarredRepository
    
    init(login: String, repository: StarredRepository) {
        self.login = login
        self.repository = repository
    }
    
    func fetch(page: Int, completion: @escaping (Result<[Repository], Error>) -> Void) {
        return repository.fetchStarred(page: page, login: login, completion: completion)
    }
}
