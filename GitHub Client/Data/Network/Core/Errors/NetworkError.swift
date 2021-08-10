//
//  NetworkError.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

import Foundation

enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}
