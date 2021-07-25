//
//  String+extensions.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 24.07.2021.
//

import Foundation

extension String {
    func html() -> String {
        return self
            .replacingOccurrences(of: "&", with: "&#38")
            .replacingOccurrences(of: "'", with: "&#39")
            .replacingOccurrences(of: ">", with: "&#62")
    }
    
    func pathWithoutParameters() -> String {
        let pattern = "\\{.*\\}"
        let range = self.range(of: pattern, options: .regularExpression)
        let clearPath = self.replacingCharacters(in: range!, with: "")
        return clearPath
    }
}
