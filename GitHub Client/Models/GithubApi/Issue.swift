//
//  Issue.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import Foundation

struct Issue: Codable {
    let id: Int
    let node_id: String?
    let url: URL?
    let repository_url: URL?
    let labels_url: String?
    let comments_url: URL?
    let events_url: URL?
    let html_url: URL?
    let number: Int?
    let state: String?
    let title: String?
    let body: String?
    let user: UserProfile?
    let labels: [LabelModel?]?
    let assignee: UserProfile?
    let assignees: [UserProfile?]?
    let milestone: Milestone?
    let locked: Bool?
    let active_lock_reason: String?
    let comments: Int?
    let pull_request: PullRequest?
    let closed_at: String?
    let created_at: String?
    let updated_at: String?
    let repository: Repository?
    let author_association: String?
}
