//
//  NotificationsRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import Foundation

protocol NotificationsRepository {
    typealias NotificationsHandler = (Result<ListResponseModel<EventNotification>, Error>) -> Void
    func fetch(_ request: NotificationsRequestModel, completion: @escaping NotificationsHandler)
}
