//
//  UsersListRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import Foundation

protocol UsersListRepository {
    func fetchFollowers(user: User, page: Int, completion: @escaping (Result<[User], Error>) -> Void)
    func fetchFollowing(user: User, page: Int, completion: @escaping (Result<[User], Error>) -> Void)
    func fetchMyFollowers(page: Int, completion: @escaping (Result<[User], Error>) -> Void)
    func fetchMyFollowing(page: Int, completion: @escaping (Result<[User], Error>) -> Void)
}
