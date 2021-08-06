//
//  TokenResponse.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import Foundation

struct TokenResponse: Codable {
    let accessToken: String
    let scope: String
    let tokenType: String
}
