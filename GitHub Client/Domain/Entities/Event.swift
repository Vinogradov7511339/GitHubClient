//
//  Event.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

struct Event: Identifiable, Equatable {

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

    let id: Int
    let eventType: Types
    let actor: User
}
