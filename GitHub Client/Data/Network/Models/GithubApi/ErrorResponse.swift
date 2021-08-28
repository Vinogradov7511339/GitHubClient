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
    let errorUri: URL
}
