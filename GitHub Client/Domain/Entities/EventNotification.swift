//
//  EventNotification.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import Foundation

struct EventNotification {

    enum SubjectType: String {
        case issue = "Issue"
        case pullRequest = "PullRequest"
        case discussion = "Discussion"
        case comment = "Comment"
    }

    let title: String
    let body: String
    let type: SubjectType
    let createdAt: Date
    let repository: Repository

}
