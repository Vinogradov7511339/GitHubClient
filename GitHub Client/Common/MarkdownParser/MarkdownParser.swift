//
//  MarkdownParser.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.07.2021.
//

import Foundation

public struct MarkdownParser {
    public static func parse(text: String) -> [MarkdownNode] {
        var parser = MarkdownParser(text: text)
        return parser.parse()
    }
    
    private var tokenizer: MarkdownTokenizer
    private var openingDelimiters: [UnicodeScalar] = []
    
    private init(text: String) {
        tokenizer = MarkdownTokenizer(text)
    }
    
    private mutating func parse() -> [MarkdownNode] {
        var elements: [MarkdownNode] = []
        
        while let token = tokenizer.nextToken() {
            switch token {
            case .text(let text):
                elements.append(.text(text))
            case .leftDelimiter(let delimiter):
                openingDelimiters.append(delimiter)
                elements.append(contentsOf: parse())
            case .rightDelimiter(let delimiter) where openingDelimiters.contains(delimiter):
                guard let containerNode = close(delimiter: delimiter, elements: elements) else {
                    fatalError("There is no MarkupNode for \(delimiter)")
                }
                return [containerNode]
            default:
                elements.append(.text(token.description))
            }
        }
        let textElements: [MarkdownNode] = openingDelimiters.map { .text(String($0))}
        elements.insert(contentsOf: textElements, at: 0)
        openingDelimiters.removeAll()
        return elements
    }
    
    private mutating func close(delimiter: UnicodeScalar, elements: [MarkdownNode]) -> MarkdownNode? {
        var newElements = elements
        while openingDelimiters.count > 0 {
            let openingDelimiter = openingDelimiters.popLast()!
            if openingDelimiter == delimiter {
                break
            } else {
                newElements.insert(.text(String(openingDelimiter)), at: 0)
            }
        }
        return MarkdownNode(delimiter: delimiter, children: newElements)
    }
}
