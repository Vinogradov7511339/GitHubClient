//
//  PullRequest.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

enum PullRequestState: String {
    case open
    case close
    case unknown
}

struct PullRequest {
    let id: Int
    let url: URL
    let diffUrl: URL
    let commitsUrl: URL
    let number: Int
    let state: PullRequestState
    let title: String
    let head: PRBaseResponseDTO
    let base: PRBaseResponseDTO
    let labels: [LabelResponseDTO]
    let createdAt: Date?
}
