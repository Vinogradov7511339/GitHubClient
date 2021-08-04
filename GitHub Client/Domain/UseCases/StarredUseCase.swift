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
    
    let user: User
    let repository: StarredRepository
    
    init(user: User, repository: StarredRepository) {
        self.user = user
        self.repository = repository
    }
    
    func fetch(page: Int, completion: @escaping (Result<[Repository], Error>) -> Void) {
        return repository.fetchStarred(page: page, user: user, completion: completion)
    }
}
