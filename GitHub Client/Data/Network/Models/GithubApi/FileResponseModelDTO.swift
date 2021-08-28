//
//  FileResponseModelDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 01.08.2021.
//

import Foundation

struct FileResponseModelDTO: Codable {
    let name: String
    let path: String
    let sha: String
    let size: Int
    let url: URL
    let htmlUrl: URL
    let gitUrl: URL
    let downloadUrl: URL
    let type: String
    let content: String
    let encoding: String?

    func toDomain() -> File {
        var content: String
        if let encoding = encoding, encoding == "base64" {
            content = self.content.fromBase64() ?? "Parse error"
        } else {
            content = self.content
        }
        return .init(name: name,
                     path: path,
                     url: url,
                     content: content,
                     size: size)
    }
}
