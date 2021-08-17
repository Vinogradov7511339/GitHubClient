//
//  Event.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

struct EventRepository {
    let id: Int
    let name: String
    let url: URL
}

struct Event: Identifiable {
    let id: Int
    let actor: User
    let repository: EventRepository
    let eventType: Types
    let eventPayload: PayloadType
    let createdAt: Date
}

struct WatchEvent {}

struct PushEvent {
    let branch: String
    let commits: [Commit]
}

struct CreateEvent {
    let repositoryName: String
    let branch: String
    let description: String?
}

struct IssueCommentEvent {
    let issue: Issue
    let comment: Comment
}

struct ForkEvent {}

extension Event {
    enum Types: String {
        case commitCommentEvent = "CommitCommentEvent"
        case createEvent = "CreateEvent"
        case deleteEvent = "DeleteEvent"
        case forkEvent = "ForkEvent"
        case gollumEvent = "GollumEvent"
        case issueCommentEvent = "IssueCommentEvent"
        case issuesEvent = "IssuesEvent"
        case memberEvent = "MemberEvent"
        case publicEvent = "PublicEvent"
        case pullRequestEvent = "PullRequestEvent"
        case pullRequestReviewEvent = "PullRequestReviewEvent"
        case pullRequestReviewCommentEvent = "PullRequestReviewCommentEvent"
        case pushEvent = "PushEvent"
        case releaseEvent = "ReleaseEvent"
        case sponsorshipEvent = "SponsorshipEvent"
        case watchEvent = "WatchEvent"
    }

    enum PayloadType {
        case watchEvent(WatchEvent)
        case pushEvent(PushEvent)
        case createEvent(CreateEvent)
        case issueCommentEvent(IssueCommentEvent)
        case forkEvent(ForkEvent)
    }
}
