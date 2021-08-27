//
//  UserResponseDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import Foundation

struct UserResponseDTO: Codable {
    let login: String
    let id: Int
    let avatarUrl: URL
    let url: URL
    let type: String

    func toDomain() -> User {
        .init(id: id,
              login: login,
              avatarUrl: avatarUrl,
              url: url,
              type: User.UserType(rawValue: type) ?? .unknown)
    }
}
