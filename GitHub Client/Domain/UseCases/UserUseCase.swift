//
//  UserProfileUseScene.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

protocol UserProfileUseCase {
    typealias UsersHandler = UserRepository.UsersHandler
    func fetchFollowers(request: UsersRequestModel, completion: @escaping UsersHandler)
    func fetchFollowing(request: UsersRequestModel, completion: @escaping UsersHandler)

    typealias ProfileHandler = UserRepository.ProfileHandler
    func fetchProfile(_ user: User, completion: @escaping ProfileHandler)

    typealias RepListHandler = RepRepository.RepListHandler
    func fetchRepositories(request: UsersRequestModel, completion: @escaping RepListHandler)
    func fetchStarred(request: UsersRequestModel, completion: @escaping RepListHandler)
}

final class UserProfileUseCaseImpl {
    let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
}

// MARK: - UserProfileUseCase
extension UserProfileUseCaseImpl: UserProfileUseCase {
    func fetchFollowers(request: UsersRequestModel, completion: @escaping UsersHandler) {
        userRepository.fetchFollowers(request: request, completion: completion)
    }

    func fetchFollowing(request: UsersRequestModel, completion: @escaping UsersHandler) {
        userRepository.fetchFollowing(request: request, completion: completion)
    }

    func fetchProfile(_ user: User, completion: @escaping ProfileHandler) {
        userRepository.fetchProfile(user, completion: completion)
    }

    func fetchRepositories(request: UsersRequestModel, completion: @escaping RepListHandler) {
        userRepository.fetchRepList(request: request, completion: completion)
    }

    func fetchStarred(request: UsersRequestModel, completion: @escaping RepListHandler) {
        userRepository.fetchStarred(request: request, completion: completion)
    }
}
