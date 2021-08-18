//
//  DirectoryResponseModelDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import Foundation

class DirectoryResponseModelDTO: Codable {

    let name: String
    let path: String
    let sha: String
    let size: Int
    let url: URL
    let htmlUrl: URL
    let gitUrl: URL
    let downloadUrl: URL?
    let type: String
    //    let _links

    init(name: String,
         path: String,
         sha: String,
         size: Int,
         url: URL, htmlUrl: URL,
         gitUrl: URL,
         downloadUrl: URL,
         type: String) {
        self.name = name
        self.path = path
        self.sha = sha
        self.size = size
        self.url = url
        self.htmlUrl = htmlUrl
        self.gitUrl = gitUrl
        self.downloadUrl = downloadUrl
        self.type = type
    }

    func toDomain() -> FolderItem {
        let type: ContentType
        if self.type == "dir" {
            type = .folder
        } else {
            type = .file
        }
        return .init(name: name,
              path: path,
              url: url,
              type: type)
    }
}
