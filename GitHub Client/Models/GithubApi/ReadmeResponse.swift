//
//  ReadmeResponse.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 01.08.2021.
//

import Foundation

class ReadmeResponse: Codable {
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
    let encoding: String
//    let _links
    
    internal init(name: String, path: String, sha: String, size: Int, url: URL, htmlUrl: URL, gitUrl: URL, downloadUrl: URL, type: String, content: String, encoding: String) {
        self.name = name
        self.path = path
        self.sha = sha
        self.size = size
        self.url = url
        self.htmlUrl = htmlUrl
        self.gitUrl = gitUrl
        self.downloadUrl = downloadUrl
        self.type = type
        self.content = content
        self.encoding = encoding
    }
}
