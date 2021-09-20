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

    var lastPage: Int? {
        let a = components(separatedBy: ",")
            .filter { $0.contains("last") }
            .first?
            .components(separatedBy: ";")
            .first?.components(separatedBy: "=")
            .last?
            .replacingOccurrences(of: ">", with: "")
        if a != "1" {
            print("aa")
        }
        return Int(a ?? "1")
    }
}

extension String {
     func fromBase64() -> String? {
         guard let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
             return nil
         }
         return String(data: data, encoding: .utf8)
     }

     func toBase64() -> String {
         return Data(self.utf8).base64EncodedString()
     }
 }
