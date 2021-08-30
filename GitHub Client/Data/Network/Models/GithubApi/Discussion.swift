//
//  Discussion.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.07.2021.
//

import Foundation

struct Discussion: Codable {
    let author: UserResponseDTO?
    let body: String?
    let bodyHtml: String?
    let bodyVersion: String?
    let commentsCount: Int?
    let commentsUrl: URL?
    let createdAt: String?
    let lastEditedAt: String?
    let htmlUrl: String?
    let nodeId: String?
    let number: Int?
    let pinned: Bool?
//    let private: Bool?
    let teamUrl: URL?
    let title: String?
    let updatedAt: String?
    let url: URL?
    let reactions: Reactions?
}
