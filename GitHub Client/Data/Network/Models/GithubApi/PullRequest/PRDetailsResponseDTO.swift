//
//  PRDetailsResponseDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import Foundation

struct PRDetailsResponseDTO: Codable {
    let url: URL
    let id: Int
    let htmlUrl: URL
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
    let merged: Bool
    let mergeable: Bool
    let rebaseable: Bool
    let mergeableState: String?
    let mergedBy: UserResponseDTO?
    let comments: Int
    let reviewComments: Int
    let maintainerCanModify: Bool
    let commits: Int
    let additions: Int
    let deletions: Int
    let changedFiles: Int

    func toDomain() -> PullRequestDetails {
        .init(number: number,
              htmlUrl: htmlUrl,
              state: PullRequestState(rawValue: state) ?? .unknown,
              title: title,
              body: body,
              head: head,
              base: base,
              labels: labels,
              commitsCount: commits,
              additionsCount: additions,
              deletionsCount: deletions,
              changedFilesCount: changedFiles)
    }
}
