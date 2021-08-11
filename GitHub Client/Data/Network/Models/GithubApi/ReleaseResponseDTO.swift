//
//  ReleaseResponseDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 11.08.2021.
//

import Foundation

struct ReleaseResponseDTO: Codable {
    let id: Int
    let name: String
    let body: String
    let createdAt: String
    let author: UserResponseDTO

    func toDomain() -> Release {
        .init(id: id,
              name: name,
              body: body,
              createdAt: createdAt,
              author: author.toDomain())
    }
}
