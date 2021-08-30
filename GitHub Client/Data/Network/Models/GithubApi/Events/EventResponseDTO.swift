//
//  EventResponseDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

struct EventResponseDTO: Codable {

    let id: String
    let type: String
    let `public`: Bool
    let payload: EventPayloadResponseDTO?
    let repo: EventRepositoryReesponseDTO
    let actor: EventUserResponseDTO
    let org: OrganzationResponseDTO?
    let createdAt: String

    func toDomain() -> Event {
        .init(event: self)
    }

    struct EventUserResponseDTO: Codable {
        let id: Int
        let login: String
        let displayLogin: String?
        let gravatarId: String?
        let url: URL
        let avatarUrl: URL
        let type: String?
    }

    struct EventRepositoryReesponseDTO: Codable {
        let id: Int
        let name: String
        let url: URL
    }

    struct EventPayloadResponseDTO: Codable {
        let ref: String? // CreateEvent, DeleteEvent
        let refType: String? // CreateEvent, DeleteEvent
        let masterBranch: String? // CreateEvent
        let description: String? // CreateEvent

        // not documented
        let pusherType: String? // CreateEvent, DeleteEvent
        let forkee: RepositoryResponseDTO? // ForkEvent

        // Can be one of created, edited, or deleted.
        let action: String? // IssueCommentEvent, IssuesEvent, PullRequestReviewEvent
        let issue: IssueResponseDTO? // IssueCommentEvent, IssuesEvent
        let comment: CommentResponseDTO? // IssueCommentEvent, PullRequestReviewCommentEvent
        let review: PullRequestReviewResponseDTO? // PullRequestReviewEvent
        let pullRequest: PRResponseDTO? // PullRequestReviewEvent, PullRequestReviewCommentEvent
        let commits: [EventCommitResponseDTO]? // PushEvent
        let release: ReleaseResponseDTO? // ReleaseEvent
    }

    struct EventCommitResponseDTO: Codable {
        let sha: String
        let author: EventCommiterResponseDTO
        let message: String
        let distinct: Bool
        let url: URL
    }

    struct EventCommiterResponseDTO: Codable {
        let email: String
        let name: String
    }
}
