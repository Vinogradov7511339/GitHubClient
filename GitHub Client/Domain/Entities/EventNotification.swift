//
//  EventNotification.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import Foundation

struct EventNotification {
    enum NotificationType: String {
        case issue = "Issue"
        case unknown
    }

    let type: NotificationType
    let updatedAt: Date?
    let notification: NotificationResponseDTO
}
