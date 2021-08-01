//
//  ErrorResponse.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import Foundation

struct ErrorResponse: Codable {
    let error: String
    let errorDescription: String
    let errorUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case error
        case errorDescription = "error_description"
        case errorUrl = "error_uri"
    }
}
