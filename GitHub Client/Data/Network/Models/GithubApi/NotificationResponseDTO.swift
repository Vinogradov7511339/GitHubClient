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
    let repository: NotificationsRepositoryResponseDTO

    func toDomain() -> EventNotification {
        .init(type: .init(rawValue: subject.type) ?? .unknown,
              updatedAt: updatedAt.toDate(),
              notification: self)
    }
}

struct NotificationsSubjectResponseDTO: Codable {
    let title: String
    let url: URL?
    let latestCommentUrl: URL?
    let type: String
}

struct NotificationsRepositoryResponseDTO: Codable {
    let id: Int
    let name: String
    let fullName: String
    let owner: UserResponseDTO
    let `private`: Bool
    let htmlUrl: URL
    let description: String
    let fork: Bool
    let url: URL
}
