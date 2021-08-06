//
//  MyProfileUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

protocol MyProfileUseCase {
    func fetch(completion: @escaping (Result<AuthenticatedUser, Error>) -> Void)
}

final class MyProfileUseCaseImpl: MyProfileUseCase {
    
    let repository: MyProfileRepository
    
    init(repository: MyProfileRepository) {
        self.repository = repository
    }
    func fetch(completion: @escaping (Result<AuthenticatedUser, Error>) -> Void) {
        repository.fetch(completion: completion)
    }
}
