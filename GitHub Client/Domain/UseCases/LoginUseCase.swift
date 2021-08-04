//
//  LoginUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

protocol LoginUseCase {
    func fetch(tokenResponse: TokenResponse, completion: @escaping (Result<AuthenticatedUser, Error>) -> Void)
}

class LoginUseCaseImpl: LoginUseCase {
    
    let repository: LoginRepository
    
    init(repository: LoginRepository) {
        self.repository = repository
    }
    
    func fetch(tokenResponse: TokenResponse, completion: @escaping (Result<AuthenticatedUser, Error>) -> Void) {
        UserStorage.shared.saveTokenResponse(tokenResponse)
        repository.fetchAuthenticatedUser(token: tokenResponse, completion: completion)
    }
}
