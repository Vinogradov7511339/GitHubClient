//
//  PullRequestReviewResponseDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.08.2021.
//

import Foundation

struct PullRequestReviewResponseDTO: Codable {
    let id: Int
    let nodeId: String
    let user: UserDetailsResponseDTO
    let body: String?
    let state: String
    let htmlUrl: URL
    let pullRequestUrl: URL
    let submittedAt: String
    let commitId: String?
    let authorAssociation: String?
}
