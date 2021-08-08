//
//  UserProfileRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

protocol UserProfileRepository {
    func fetch(user: User, completion: @escaping (Result<UserDetails, Error>) -> Void)
}
