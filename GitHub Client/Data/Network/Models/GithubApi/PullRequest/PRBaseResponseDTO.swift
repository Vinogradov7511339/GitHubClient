//
//  PRBaseResponseDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import Foundation

struct PRBaseResponseDTO: Codable {
    let label: String
    let user: UserResponseDTO
    let repo: RepositoryResponseDTO
}
