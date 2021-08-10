//
//  LoginRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

protocol LoginRepository {
    func fetchToken(authCode: String, completion: @escaping (Result<TokenResponse, Error>) -> Void)
}
