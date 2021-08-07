//
//  DataTransferError.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}
