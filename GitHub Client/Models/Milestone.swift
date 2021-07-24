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
    let html_url: URL?
    let labels_url: URL?
    let id: Int
    let node_id: String?
    let number: Int?
    let state: String?
    let title: String?
    let description: String?
    let creator: UserProfile?
    let open_issues: Int?
    let closed_issues: Int?
    let created_at: String?
    let updated_at: String?
    let due_on: String?
}
