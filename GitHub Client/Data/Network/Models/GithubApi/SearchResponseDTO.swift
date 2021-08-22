//
//  SearchResponseDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import Foundation

struct SearchResponseDTO<Item: Codable>: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Item]
}
