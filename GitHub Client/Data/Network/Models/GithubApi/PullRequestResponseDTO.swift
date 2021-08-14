//
//  PullRequestResponseDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import Foundation

struct PullRequestResponseDTO: Codable {
    let url: URL
    let id: Int?
    let nodeId: String?
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
    let state: String
    let locked: Bool?
    let title: String
    let user: UserResponseDTO?
    let body: String?
    let labels: [LabelModel?]?
    let milestone: Milestone?
    let activeLockReason: String?
    let createdAt: String?
    let updatedAt: String?
    let closedAt: String?
    let mergedAt: String?
    let mergeCommitSha: String?
    let assignee: UserResponseDTO?
    let assignees: [UserResponseDTO?]?
    let requestedReviewers: [UserResponseDTO?]?
//    let requested_teams: Any
//    let head: Any
//    let base: Any

    func toDomain() -> PullRequest? {
        guard let id = id else {
            return nil
        }
        guard let user = user else {
            return nil
        }
        guard let assignee = assignee else {
            return nil
        }
        return PullRequest.init(
            id: id,
            number: number ?? -1,
            state: state,
            title: title,
            user: user.toDomain(),
            body: body,
            assignedTo: assignee.toDomain()
        )
    }
}
