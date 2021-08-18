//
//  PermissionsResponseDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import Foundation

struct PermissionsResponseDTO: Codable {
    let permissions: [String: String]
}
