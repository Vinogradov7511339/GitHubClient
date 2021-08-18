//
//  UsersListUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 12.08.2021.
//

import Foundation

protocol UsersUseCase {
    typealias UsersHandler = (Result<UsersResponseModel, Error>) -> Void
    func fetchUsers(request: UsersRequestModel, completion: @escaping UsersHandler)
}

final class UsersUseCaseImpl {

    private let repository: UsersRepository

    init(repository: UsersRepository) {
        self.repository = repository
    }
}

// MARK: - UsersUseCase
extension UsersUseCaseImpl: UsersUseCase {
    func fetchUsers(request: UsersRequestModel, completion: @escaping UsersHandler) {
        repository.fetch(requestModel: request, completion: completion)
    }
}
