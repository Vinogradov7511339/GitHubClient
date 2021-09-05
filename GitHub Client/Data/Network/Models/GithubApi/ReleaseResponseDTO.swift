//
//  ReleaseResponseDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 11.08.2021.
//

import Foundation

struct ReleaseResponseDTO: Codable {
    let id: Int
    let htmlUrl: URL
    let url: URL
    let tagName: String
    let targetCommitish: String
    let reactions: Reactions?
    let name: String
    let body: String
    let createdAt: String
    let publishedAt: String
    let author: UserResponseDTO

    func toDomain() -> Release {
        .init(id: id,
              tagName: tagName,
              targetCommitish: targetCommitish,
              name: name,
              body: body,
              createdAt: createdAt.toDate(),
              publishedAt: publishedAt.toDate(),
              author: author.toDomain(),
              reactions: reactions,
              url: url,
              htmlUrl: htmlUrl)
    }
}
