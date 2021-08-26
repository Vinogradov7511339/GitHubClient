//
//  IssuesFilter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 26.08.2021.
//

import Foundation

struct IssuesFilter {
    enum State: String {
        case all
        case open
        case closed
    }

    enum Sort: String {
        case created
        case updated
        case comments
    }

    enum Direction: String {
        case ascending = "ask"
        case descending = "desc"
    }

    let state: State
    let sort: Sort
    let direction: Direction
    let perPage: Int

/// Can be the name of a user. Pass in none for issues with no assigned user,
/// and * for issues assigned to any user.
    let assignee: String?

    // The user that created the issue.
    let creator: String?

    // A user that's mentioned in the issue.
    let mentioned: String?

    let labels: [String]

    let since: Date?
}
