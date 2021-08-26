//
//  DirectoryResponseModelDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import Foundation

struct DirectoryResponseModelDTO: Codable {

    let name: String
    let path: String
    let sha: String
    let size: Int
    let url: URL
    let htmlUrl: URL
    let gitUrl: URL
    let downloadUrl: URL
    let type: String
    //    let _links

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
