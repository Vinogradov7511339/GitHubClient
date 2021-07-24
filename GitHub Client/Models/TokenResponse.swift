//
//  TokenResponse.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import Foundation

struct TokenResponse: Codable {
    let access_token: String
    let scope: String
    let token_type: String
}
