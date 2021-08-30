//
//  IssueResponseDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import Foundation

struct IssueResponseDTO: Codable {
    let id: Int
    let url: URL
    let repositoryUrl: URL?
    let labelsUrl: String?
    let commentsUrl: URL
    let eventsUrl: URL?
    let htmlUrl: URL
    let number: Int
    let state: String
    let title: String
    let body: String?
    let user: UserResponseDTO
    let labels: [LabelResponseDTO?]?
    let assignee: UserResponseDTO?
    let assignees: [UserResponseDTO?]?
    let milestone: Milestone?
    let locked: Bool?
    let activeLockReason: String?
    let comments: Int
    let pullRequest: IssuePullRequestResponseDTO?
    let closedAt: String?
    let createdAt: String
    let updatedAt: String?
    let repository: RepositoryResponseDTO?
    let authorAssociation: String?

    struct IssuePullRequestResponseDTO: Codable {
        let url: URL
        let htmlUrl: URL
        let diffUrl: URL
        let patchUrl: URL
    }

    func toDomain() -> Issue {
        .init(
            id: id,
            number: number,
            url: url,
            htmlUrl: htmlUrl,
            commentsURL: commentsUrl,
            state: IssueState(rawValue: state) ?? .unknown,
            title: title,
            body: body ?? "",
            user: user.toDomain(),
            commentsCount: comments,
            createdAt: createdAt.toDate()
        )
    }
}
