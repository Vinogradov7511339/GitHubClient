//
//  Encodable+toDictionary.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

import Foundation

extension Encodable {
    func toDictionary() throws -> BodyType? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? BodyType
    }
}
