//
//  LabelModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import Foundation

struct LabelResponseDTO: Codable {
    let id: Int
    let url: URL
    let name: String
    let color: String
    let `default`: Bool
    let description: String
}
