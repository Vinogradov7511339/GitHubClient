//
//  Issue.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import Foundation

struct Issue: Codable {
    let id: Int
    let nodeId: String?
    let url: URL?
    let repositoryUrl: URL?
    let labelsUrl: String?
    let commentsUrl: URL?
    let eventsUrl: URL?
    let htmlUrl: URL?
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
    let activeLockReason: String?
    let comments: Int?
    let pullRequest: PullRequest?
    let closedAt: String?
    let createdAt: String?
    let updatedAt: String?
    let repository: Repository?
    let authorAssociation: String?
}
