//
//  PullRequest.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import Foundation

struct PullRequest: Codable {
    let url: URL
    let id: Int
    let nodeId: String
    let htmlUrl: URL?
    let diffUrl: URL?
    let patchUrl: URL?
    let issueUrl: URL?
    let commitsUrl: URL?
    let reviewCommentsUrl: URL?
    let reviewCommentUrl: String?
    let commentsUrl: URL?
    let statusesUrl: URL?
    let number: Int?
    let state: String?
    let locked: Bool?
    let title: String?
    let user: UserProfile?
    let body: String
    let labels: [LabelModel?]?
    let milestone: Milestone?
    let activeLockReason: String?
    let createdAt: String?
    let updatedAt: String?
    let closedAt: String?
    let mergedAt: String?
    let mergeCommitSha: String?
    let assignee: UserProfile?
    let assignees: [UserProfile?]?
    let requestedReviewers: [UserProfile?]?
//    let requested_teams: Any
//    let head: Any
//    let base: Any
}
