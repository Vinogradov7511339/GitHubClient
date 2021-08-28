//
//  PullRequestResponseDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import Foundation

struct PRResponseDTO: Codable {
    let url: URL
    let id: Int
    let htmlUrl: URL
    let diffUrl: URL
    let issueUrl: URL?
    let number: Int
    let state: String
    let locked: Bool
    let title: String
    let user: UserResponseDTO
    let body: String
    let createdAt: String
    let updatedAt: String?
    let closedAt: String?
    let mergedAt: String?
    let assignee: UserResponseDTO?
    let assignees: [UserResponseDTO]
    let requestedReviewers: [UserResponseDTO]
    let requestedTeams: [TeamResponseDTO]
    let labels: [LabelResponseDTO]
    let commitsUrl: URL
    let reviewCommentsUrl: URL
    let statusesUrl: URL
    let head: PRBaseResponseDTO
    let base: PRBaseResponseDTO
    let authorAssociation: String

    func toDomain() -> PullRequest {
        .init(id: id,
              url: url,
              diffUrl: diffUrl,
              commitsUrl: commitsUrl,
              number: number,
              state: PullRequestState(rawValue: state) ?? .unknown,
              title: title,
              head: head,
              base: base,
              labels: labels,
              createdAt: createdAt.toDate())
    }
}
