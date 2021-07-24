//
//  TokenResponse.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import Foundation

struct TokenResponse: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String
    let refresh_token_expires_in: Int
    let scope: String
    let token_type: String
}
