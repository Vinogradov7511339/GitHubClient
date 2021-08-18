//
//  NotificationsEndpoints.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import Foundation

struct NotificationsEndpoints {
    static func getNotifications() -> Endpoint<[NotificationResponseDTO]> {
        return Endpoint(path: "notifications")
    }
}
