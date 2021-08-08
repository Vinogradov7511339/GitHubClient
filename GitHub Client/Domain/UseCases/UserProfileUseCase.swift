//
//  UserProfileUseScene.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

protocol UserProfileUseCase {
    func fetch(user: User, completion: @escaping (Result<UserDetails, Error>) -> Void)
}

final class UserProfileUseCaseImpl {
    let repository: UserProfileRepository

    init(repository: UserProfileRepository) {
        self.repository = repository
    }
}

// MARK: - UserProfileUseCase
extension UserProfileUseCaseImpl: UserProfileUseCase {
    func fetch(user: User, completion: @escaping (Result<UserDetails, Error>) -> Void) {
        repository.fetch(user: user, completion: completion)
    }
}
