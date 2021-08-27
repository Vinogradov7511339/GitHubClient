//
//  TeamResponseDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import Foundation

struct TeamResponseDTO: Codable {
    let name: String
    let id: Int
    let slug: String?
    let description: String?
    let privacy: String?
    let url: URL
    let membersUrl: String?
    let repositoriesUrl: URL
    let permission: String?
}
