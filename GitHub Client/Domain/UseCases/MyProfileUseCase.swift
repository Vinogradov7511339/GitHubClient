//
//  MyProfileUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

struct UserEventsRequestModel {
    let user: User
    let page: Int
}

protocol MyProfileUseCase {
    func fetch(completion: @escaping (Result<AuthenticatedUser, Error>) -> Void)
    func fetchEvents(request: UserEventsRequestModel, completion: @escaping (Result<[Event], Error>) -> Void)
}

final class MyProfileUseCaseImpl {
    let repository: MyProfileRepository

    init(repository: MyProfileRepository) {
        self.repository = repository
    }
}

// MARK: - MyProfileUseCase
extension MyProfileUseCaseImpl: MyProfileUseCase {
    func fetch(completion: @escaping (Result<AuthenticatedUser, Error>) -> Void) {
        repository.fetch(completion: completion)
    }

    func fetchEvents(request: UserEventsRequestModel, completion: @escaping (Result<[Event], Error>) -> Void) {
        repository.fetchEvents(request: request, completion: completion)
    }
}
