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
    func fetchProfile(_ userUrl: URL, completion: @escaping ProfileHandler)

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
extension UserProfileUseCaseImpl : UserProfileUseCase {
    func fetchFollowers(request: UsersRequestModel, completion: @escaping UsersHandler) {
        userRepository.fetchFollowers(request: request, completion: completion)
    }

    func fetchFollowing(request: UsersRequestModel, completion: @escaping UsersHandler) {
        userRepository.fetchFollowing(request: request, completion: completion)
    }

    func fetchProfile(_ userUrl: URL, completion: @escaping ProfileHandler) {
        userRepository.fetchProfile(userUrl) { result in
            switch result {
            case .success(var userProfile):
                self.fetchLastEvents(userProfile.eventsUrl) { result in
                    switch result {
                    case .success(let model):
                        userProfile.lastEvents = model.items
                        completion(.success(userProfile))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchRepositories(request: UsersRequestModel, completion: @escaping RepListHandler) {
        userRepository.fetchRepList(request: request, completion: completion)
    }

    func fetchStarred(request: UsersRequestModel, completion: @escaping RepListHandler) {
        userRepository.fetchStarred(request: request, completion: completion)
    }
}

// MARK: - Private
private extension UserProfileUseCaseImpl {
    typealias EventsHandler = UserRepository.EventsHandler
    func fetchLastEvents(_ url: URL, completion: @escaping EventsHandler) {
       let model = EventsRequestModel(path: url, page: 1, perPage: 10)
        userRepository.fetchEvents(request: model, completion: completion)
    }
}
