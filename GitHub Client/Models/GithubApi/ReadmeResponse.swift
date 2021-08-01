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
    let html_url: URL
    let git_url: URL
    let download_url: URL
    let type: String
    let content: String
    let encoding: String
//    let _links
    
    init(name: String, path: String, sha: String, size: Int, url: URL, html_url: URL, git_url: URL, download_url: URL, type: String, content: String, encoding: String) {
        self.name = name
        self.path = path
        self.sha = sha
        self.size = size
        self.url = url
        self.html_url = html_url
        self.git_url = git_url
        self.download_url = download_url
        self.type = type
        self.content = content
        self.encoding = encoding
    }
}
