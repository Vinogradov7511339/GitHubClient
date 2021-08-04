//
//  LoginRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

class LoginRepositoryImpl: LoginRepository {
    
    private let service = ServicesManager.shared.userService
    
    func fetchAuthenticatedUser(token: TokenResponse, completion: @escaping (Result<AuthenticatedUser, Error>) -> Void) {
        service.fetchMyProfile(token: token) { profile, error in
            if let profile = profile {
                let mapped = profile.mapToAuthotization()
                completion(.success(mapped))
            } else {
                completion(.failure(CustomError()))
            }
        }
    }
}
