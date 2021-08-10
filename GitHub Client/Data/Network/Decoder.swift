//
//  Decoder.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

import Foundation

protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

final class JSONResponseDecoder {
    private let jsonDecoder: JSONDecoder

    public init(strategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) {
        jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = strategy
    }
}

// MARK: - ResponseDecoder
extension JSONResponseDecoder: ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
