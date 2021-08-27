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
//    let head
    let authorAssociation: String

    func toDomain() -> PullRequest {
        .init(id: id,
              url: url,
              number: number,
              state: PullRequestState(rawValue: state) ?? .unknown,
              title: title,
              labels: labels,
              createdAt: createdAt.toDate())
    }
}
