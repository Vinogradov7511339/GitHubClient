//
//  Issue.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

enum IssueState: String {
    case open
    case close
    case unknown
}

struct Issue {
    let id: Int
    let number: Int
    let url: URL
    let repositoryUrl: URL
    let htmlUrl: URL
    let commentsURL: URL
    let state: IssueState
    let title: String
    let body: String
    let user: User
    let commentsCount: Int
    let createdAt: Date?
    let labels: [LabelResponseDTO]
}
