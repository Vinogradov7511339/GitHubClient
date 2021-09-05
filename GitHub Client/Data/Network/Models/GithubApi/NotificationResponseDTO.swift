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

    func toDomain() -> EventNotification? {
        .init(notification: self)
    }

//    func toDomain() -> EventNotification? {
//        guard let type = EventNotification.SubjectType(rawValue: subject.type) else {
//            assert(false, "no type")
//            return nil
//        }
//        guard let createdAt = updatedAt.toDate() else {
//            assert(false, "no date")
//            return nil
//        }
//        guard let repository = repository.toDomain() else {
//            assert(false, "can not convert repository")
//            return nil
//        }
//        guard let title = url.absoluteString.split(separator: "/").last else {
//            assert(false, "not a number")
//            return nil
//        }
//        let fullTitle = "\(repository.owner.login) / \(repository.name) #\(title)"
//        return .init(title: fullTitle,
//                     body: subject.title,
//                     type: type,
//                     createdAt: createdAt,
//                     repository: repository)
//    }
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
