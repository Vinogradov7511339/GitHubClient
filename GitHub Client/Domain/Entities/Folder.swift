//
//  Folder.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 17.08.2021.
//

import Foundation

enum ContentType {
    case folder
    case file
}

struct FolderItem {
    let name: String
    let path: String
    let url: URL
    let type: ContentType
}

struct File {
    let name: String
    let path: String
    let url: URL
    let content: String
    let size: Int
}
