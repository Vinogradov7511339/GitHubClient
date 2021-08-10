//
//  LoginRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

import Foundation

final class LoginRepositoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - LoginRepository
extension LoginRepositoryImpl: LoginRepository {
    func fetchToken(authCode: String, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let endpoint = LoginEndpoint.token(authCode: authCode)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                completion(.success(response.model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
