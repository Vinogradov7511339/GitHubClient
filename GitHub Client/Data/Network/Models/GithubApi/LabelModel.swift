//
//  LabelModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import Foundation

struct LabelModel: Codable {
    let id: Int
    let nodeId: String?
    let url: URL?
    let name: String?
    let description: String?
    let color: String?
//    let default: Bool?
}
