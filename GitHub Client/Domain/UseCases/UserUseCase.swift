//
//  UserProfileUseScene.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

protocol UserProfileUseCase {
    typealias ProfileHandler = UserRepository.ProfileHandler
    func fetchProfile(_ userUrl: URL, completion: @escaping ProfileHandler)
}

final class UserProfileUseCaseImpl {
    let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
}

// MARK: - UserProfileUseCase
extension UserProfileUseCaseImpl : UserProfileUseCase {
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
}

// MARK: - Private
private extension UserProfileUseCaseImpl {
    typealias EventsHandler = UserRepository.EventsHandler
    func fetchLastEvents(_ url: URL, completion: @escaping EventsHandler) {
       let model = EventsRequestModel(path: url, page: 1, perPage: 10)
        userRepository.fetchEvents(request: model, completion: completion)
    }
}
