//
//  PullRequest.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import Foundation

struct PullRequest: Codable {
    let url: URL
    let id: Int?
    let node_id: String?
    let html_url: URL?
    let diff_url: URL?
    let patch_url: URL?
    let issue_url: URL?
    let commits_url: URL?
    let review_comments_url: URL?
    let review_comment_url: String?
    let comments_url: URL?
    let statuses_url: URL?
    let number: Int?
    let state: String?
    let locked: Bool?
    let title: String?
    let user: UserProfile?
    let body: Data?
    let labels: [LabelModel?]?
    let milestone: Milestone?
    let active_lock_reason: String?
    let created_at: String?
    let updated_at: String?
    let closed_at: String?
    let merged_at: String?
    let merge_commit_sha: String?
    let assignee: UserProfile?
    let assignees: [UserProfile?]?
    let requested_reviewers: [UserProfile?]?
//    let requested_teams: Any
//    let head: Any
//    let base: Any
    
}
