//
//  NotificationsEndpoints.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import Foundation

struct NotificationsEndpoints {
    static func getNotifications(_ request: NotificationsRequestModel) -> Endpoint<[NotificationResponseDTO]> {
        var params: QueryType = [:]
        params["page"] = "\(request.page)"
        params["per_page"] = "\(request.filter.perPage)"
        return Endpoint(path: "notifications",
                        queryParametersEncodable: params)
    }
}
