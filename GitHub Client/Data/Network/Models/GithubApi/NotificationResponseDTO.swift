//
//  NotificationResponseDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import Foundation

struct NotificationResponseDTO: Codable {
    let id: String
    let unread: Bool
    let reason: String
    let updatedAt: String
    let lastReadAt: String?
    let url: URL
    let subscriptionUrl: URL
    let subject: NotificationsSubjectResponseDTO
    let repository: RepositoryResponseDTO
// Issue/PullRequest/Discussion,  has repository
    func toDomain() -> EventNotification? {
        guard let type = EventNotification.SubjectType(rawValue: subject.type) else {
            assert(false, "no type")
            return nil
        }
        guard let createdAt = updatedAt.toDate() else {
            assert(false, "no date")
            return nil
        }
        guard let repository = repository.toDomain() else {
            assert(false, "can not convert repository")
            return nil
        }
        return .init(title: subject.title,
                     type: type,
                     createdAt: createdAt,
                     repository: repository)
    }

}

struct NotificationsSubjectResponseDTO: Codable {
    let title: String
    let url: URL?
    let latestCommentUrl: URL?
    let type: String
}
