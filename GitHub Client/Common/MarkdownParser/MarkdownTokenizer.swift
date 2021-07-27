//
//  MarkdownTokenizer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.07.2021.
//

import Foundation

private extension CharacterSet {
    static let delimiters = CharacterSet(charactersIn: "*_~")
    static let whitespaceAndPunctuation = CharacterSet.whitespacesAndNewlines
        .union(CharacterSet.punctuationCharacters)
        .union(CharacterSet(charactersIn: "~"))
}

private extension UnicodeScalar {
    static let space: UnicodeScalar = " "
}

struct MarkdownTokenizer {
    
    private let input: String.UnicodeScalarView
    
    private var currentIndex: String.UnicodeScalarView.Index
    private var leftDelimiters: [UnicodeScalar] = []
    
    init(_ string: String) {
        input = string.unicodeScalars
        currentIndex = string.unicodeScalars.startIndex
    }
    
    mutating func nextToken() -> MarkdownToken? {
        guard let c = current else {
            return nil
        }
        var token: MarkdownToken?
        if CharacterSet.delimiters.contains(c) {
            token = scan(delimiter: c)
        } else {
            token = scanText()
        }
        
        if token == nil {
            token = .text(String(c))
            advance()
        }
        return token
    }
    
    private var current: UnicodeScalar? {
        guard currentIndex < input.endIndex else {
            return nil
        }
        return input[currentIndex]
    }
    
    private var previous: UnicodeScalar? {
        guard currentIndex > input.startIndex else {
            return nil
        }
        let index = input.index(before: currentIndex)
        return input[index]
    }
    
    private var next: UnicodeScalar? {
        guard currentIndex < input.endIndex else {
            return nil
        }
        let index = input.index(after: currentIndex)
        guard index < input.endIndex else {
            return nil
        }
        return input[index]
    }
    
    private mutating func scan(delimiter d: UnicodeScalar) -> MarkdownToken? {
        return scanRight(delimiter: d) ?? scanLeft(delimiter: d)
    }
    
    private mutating func scanLeft(delimiter d: UnicodeScalar) -> MarkdownToken? {
        let p = previous ?? .space
        guard let n = next else {
            return nil
        }
        guard CharacterSet.whitespaceAndPunctuation.contains(p) &&
                !CharacterSet.whitespacesAndNewlines.contains(n) &&
                !leftDelimiters.contains(d) else {
            return nil
        }
        leftDelimiters.append(d)
        advance()
        return .leftDelimiter(d)
    }
    
    private mutating func scanRight(delimiter d: UnicodeScalar) -> MarkdownToken? {
        guard let p = previous else {
            return nil
        }
        let n = next ?? .space
        guard !CharacterSet.whitespacesAndNewlines.contains(p) &&
                CharacterSet.whitespaceAndPunctuation.contains(n) &&
                leftDelimiters.contains(d) else {
            return nil
        }
        while !leftDelimiters.isEmpty {
            if leftDelimiters.popLast() == d {
                break
            }
        }
        advance()
        return .rightDelimiter(d)
    }
    
    private mutating func scanText() -> MarkdownToken? {
        let startIndex = currentIndex
        scanUntil { CharacterSet.delimiters.contains($0) }
        guard currentIndex > startIndex else {
            return nil
        }
        return .text(String(input[startIndex..<currentIndex]))
    }
    
    private mutating func scanUntil(_ predicate: (UnicodeScalar) -> Bool) {
        while currentIndex < input.endIndex && !predicate(input[currentIndex]) {
            advance()
        }
    }
    
    private mutating func advance() {
        currentIndex = input.index(after: currentIndex)
    }
}
