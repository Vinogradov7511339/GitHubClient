//
//  CommentResponse.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 03.08.2021.
//

import Foundation

class CommentResponseDTO: Codable {
    let htmlUrl: URL
    let url: URL
    let id: Int
    let nodeId: String
    let body: String
    let path: String?
    let position: Int?
    let line: Int?
    let commitId: String?
    let user: UserResponseDTO
    let createdAt: String
    let updatedAt: String
    let authorAssociation: String

    init(htmlUrl: URL,
         url: URL,
         id: Int,
         nodeId: String,
         body: String,
         path: String,
         position: Int,
         line: Int,
         commitId: String,
         user: UserResponseDTO,
         createdAt: String,
         updatedAt: String,
         authorAssociation: String) {
        self.htmlUrl = htmlUrl
        self.url = url
        self.id = id
        self.nodeId = nodeId
        self.body = body
        self.path = path
        self.position = position
        self.line = line
        self.commitId = commitId
        self.user = user
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.authorAssociation = authorAssociation
    }

    func toDomain() -> Comment {
        .init(
            id: id,
            body: body,
            user: user.map()
        )
    }
}
