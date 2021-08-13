//
//  IssueResponseDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import Foundation

struct IssueResponseDTO: Codable {
    let id: Int
    let nodeId: String?
    let url: URL?
    let repositoryUrl: URL?
    let labelsUrl: String?
    let commentsUrl: URL
    let eventsUrl: URL?
    let htmlUrl: URL?
    let number: Int
    let state: String?
    let title: String?
    let body: String?
    let user: UserResponseDTO?
    let labels: [LabelModel?]?
    let assignee: UserResponseDTO?
    let assignees: [UserResponseDTO?]?
    let milestone: Milestone?
    let locked: Bool?
    let activeLockReason: String?
    let comments: Int?
    let pullRequest: IssuePullRequestResponseDTO?
    let closedAt: String?
    let createdAt: String?
    let updatedAt: String?
    let repository: RepositoryResponseDTO?
    let authorAssociation: String?

    struct IssuePullRequestResponseDTO: Codable {
        let url: URL
        let htmlUrl: URL
        let diffUrl: URL
        let patchUrl: URL
    }

    func toDomain() -> Issue? {
        guard let user = user?.toDomain() else {
            return nil
        }
        return Issue(
            id: id,
            number: number,
            commentsURL: commentsUrl,
            state: state ?? "NaN",
            title: title ?? "NaN",
            body: body ?? "NaN",
            user: user
        )
    }
}
