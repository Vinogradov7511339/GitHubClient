//
//  MarkdownNode.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.07.2021.
//

import Foundation


public enum MarkdownNode {
    case text(String)
    case strong([MarkdownNode])
    case emphasis([MarkdownNode])
    case delete([MarkdownNode])
}

extension MarkdownNode: Equatable {}

extension MarkdownNode {
    init?(delimiter: UnicodeScalar, children: [MarkdownNode]) {
        switch delimiter {
        case "*": self = .strong(children)
        case "_": self = .emphasis(children)
        case "~": self = .delete(children)
        default: return nil
        }
    }
}
