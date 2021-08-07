//
//  DataTransferErrorResolver.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

protocol DataTransferErrorResolver {
    func resolve(error: NetworkError) -> Error
}

// MARK: - Error Resolver
final class DataTransferErrorResolverImpl {}

// MARK: - DataTransferErrorResolver
extension DataTransferErrorResolverImpl: DataTransferErrorResolver {
    func resolve(error: NetworkError) -> Error {
        return error
    }
}
