//
//  MarkdownToken.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.07.2021.
//

import Foundation

enum MarkdownToken {
    case text(String)
    case leftDelimiter(UnicodeScalar)
    case rightDelimiter(UnicodeScalar)
}

extension MarkdownToken: Equatable {}

extension MarkdownToken: CustomStringConvertible {
    var description: String {
        switch self {
        case .text(let value):
            return value
        case .leftDelimiter(let value):
        return String(value)
        case .rightDelimiter(let value):
            return String(value)
        }
    }
}

extension MarkdownToken: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .text(let value):
            return "text\(value)"
        case .leftDelimiter(let value):
            return "leftDelimiter\(value)"
        case .rightDelimiter(let value):
            return "rightDelimiter\(value)"
        }
    }
}
