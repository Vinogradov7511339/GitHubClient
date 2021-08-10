//
//  LoginUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

protocol LoginUseCase {
    func fetchToken(authCode: String, completion: @escaping (Result<TokenResponse, Error>) -> Void)
}

final class LoginUseCaseImpl {

    private let repository: LoginRepository
    private let storage = UserStorage.shared

    init(repository: LoginRepository) {
        self.repository = repository
    }
}

// MARK: - LoginUseCase
extension LoginUseCaseImpl: LoginUseCase {
    func fetchToken(authCode: String, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        repository.fetchToken(authCode: authCode) { result in
            switch result {
            case .success(let tokenResponse):
                self.storage.saveTokenResponse(tokenResponse)
                completion(.success(tokenResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
