//
//  UsersListUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import Foundation

enum UsersListType {
    case following
    case followers
}

protocol UsersListUseCase {
    func fetchMy(type: UsersListType, page: Int, completion: @escaping (Result<[User], Error>) -> Void)
    func fetch(user: User, type: UsersListType, page: Int, completion: @escaping (Result<[User], Error>) -> Void)
}

class UsersListUseCaseImpl: UsersListUseCase {
    
    private let repository: UsersListRepository
    
    init(repository: UsersListRepository) {
        self.repository = repository
    }
    
    func fetchMy(type: UsersListType, page: Int, completion: @escaping (Result<[User], Error>) -> Void) {
        switch type {
        case .followers:
            repository.fetchMyFollowers(page: page, completion: completion)
        case .following:
            repository.fetchMyFollowing(page: page, completion: completion)
        }
    }
    
    func fetch(user: User, type: UsersListType, page: Int, completion: @escaping (Result<[User], Error>) -> Void) {
        switch type {
        case .followers:
            repository.fetchFollowers(user: user, page: page, completion: completion)
        case .following:
            repository.fetchFollowing(user: user, page: page, completion: completion)
        }
    }
}
