//
//  Reactions.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.07.2021.
//

import Foundation

struct Reactions: Codable {
    let url: URL
    let totalCount: Int
    let plusOne: Int
    let minusOne: Int
    let laugh: Int
    let confused: Int
    let heart: Int
    let hooray: Int
    let eyes: Int
    let rocket: Int

    enum CodingKeys: String, CodingKey {
        case url
        case totalCount = "total_count"
        case plusOne = "+1"
        case minusOne = "-1"
        case laugh
        case confused
        case heart
        case hooray
        case eyes
        case rocket
    }
}
