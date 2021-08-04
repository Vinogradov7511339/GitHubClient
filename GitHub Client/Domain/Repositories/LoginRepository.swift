//
//  LoginRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

protocol LoginRepository {
    func fetchAuthenticatedUser(token: TokenResponse, completion: @escaping (Result<AuthenticatedUser, Error>) -> Void)
}
