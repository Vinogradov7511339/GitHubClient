//
//  Typealiases+Enums.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

import Foundation

typealias QueryType = [String: String]
typealias BodyType = [String: Any]

enum HTTPMethodType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum BodyEncoding {
    case jsonSerializationData
    case stringEncodingAscii
}
