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

    struct EventUserResponseDTO: Codable {
        let id: Int
        let login: String
        let displayLogin: String?
        let gravatarId: String?
        let url: URL
        let avatarUrl: URL
        let type: String

        func toDomain() -> User {
            .init(id: id,
                  login: login,
                  avatarUrl: avatarUrl,
                  url: url,
                  type: User.UserType(rawValue: type) ?? .unknown)
        }
    }

    struct EventRepositoryReesponseDTO: Codable {
        let id: Int
        let name: String
        let url: URL

        func toDomain() -> EventRepository {
            .init(id: id, name: name, url: url)
        }
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

        func toDomain() -> Commit {
            return .init(sha: sha, author: author.toDomain(), message: message, url: url)
        }
    }

    struct EventCommiterResponseDTO: Codable {
        let email: String
        let name: String

        func toDomain() -> Commit.Author {
            .init(email: email, name: name)
        }
    }

    func toDomain() -> Event? {
        guard let intId = Int(id) else {
            return nil
        }
        guard let eventType = Event.Types(rawValue: type) else {
            return nil
        }
        guard let payloadType = eventPayload(type: eventType) else {
            return nil
        }
        guard let date = createdAt.toDate() else {
            return nil
        }
        return Event(id: intId,
                     actor: actor.toDomain(),
                     repository: repo.toDomain(),
                     eventType: eventType,
                     eventPayload: payloadType,
                     createdAt: date)
    }

    private func eventPayload(type: Event.Types) -> Event.PayloadType? {
        switch type {
        case .commitCommentEvent: return nil
        case .createEvent: return createEvent()
        case .deleteEvent: return nil
        case .forkEvent: return forkEvent()
        case .gollumEvent: return nil
        case .issueCommentEvent: return issueCommentEvent()
        case .issuesEvent: return nil
        case .memberEvent: return nil
        case .publicEvent: return nil
        case .pullRequestEvent: return nil
        case .pullRequestReviewEvent: return nil
        case .pullRequestReviewCommentEvent: return pullRequestReviewCommentEvent()
        case .pushEvent: return pushEvent()
        case .releaseEvent: return nil
        case .sponsorshipEvent: return nil
        case .watchEvent: return watchEvent()
        }
    }

    private func watchEvent() -> Event.PayloadType? {
        let watchEvent = WatchEvent()
        return Event.PayloadType.watchEvent(watchEvent)
    }

    private func forkEvent() -> Event.PayloadType? {
        let forkEvent = ForkEvent()
        return Event.PayloadType.forkEvent(forkEvent)
    }

    private func issueCommentEvent() -> Event.PayloadType? {
        guard let issue = payload?.issue?.toDomain() else { return nil }
        guard let comment = payload?.comment?.toDomain() else {
            return nil
        }
        let issueCommentEvent = IssueCommentEvent(issue: issue, comment: comment)
        return Event.PayloadType.issueCommentEvent(issueCommentEvent)
    }

    private func pullRequestReviewCommentEvent() -> Event.PayloadType? {
        guard let commits = payload?.commits else {
            return nil
        }
        guard let branch = payload?.ref?.split(separator: "/").last else { return nil }
        let pushEvent = PushEvent(branch: String(branch), commits: commits.map { $0.toDomain() })
        return Event.PayloadType.pushEvent(pushEvent)
    }

    private func pushEvent() -> Event.PayloadType? {
        guard let commits = payload?.commits else { return nil }
        guard let branch = payload?.ref?.split(separator: "/").last else { return nil }
        let pushEvent = PushEvent(branch: String(branch), commits: commits.map { $0.toDomain() })
        return Event.PayloadType.pushEvent(pushEvent)
    }

    private func createEvent() -> Event.PayloadType? {
        guard let ref = payload?.ref else { return nil }
        guard let branch = payload?.masterBranch else { return nil }
        guard let description = payload?.description else { return nil }
        let createEvent = CreateEvent(repositoryName: ref, branch: branch, description: description)
        return Event.PayloadType.createEvent(createEvent)
    }
}
