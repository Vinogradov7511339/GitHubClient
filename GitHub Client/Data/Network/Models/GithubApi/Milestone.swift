//
//  Milestone.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import Foundation

// https://docs.github.com/en/rest/reference/issues
struct Milestone: Codable {
    let url: URL?
    let htmlUrl: URL?
    let labelsUrl: URL?
    let id: Int
    let nodeId: String?
    let number: Int?
    let state: String?
    let title: String?
    let description: String?
    let creator: UserResponseDTO?
    let openIssues: Int?
    let closedIssues: Int?
    let createdAt: String?
    let updatedAt: String?
    let dueOn: String?
}
