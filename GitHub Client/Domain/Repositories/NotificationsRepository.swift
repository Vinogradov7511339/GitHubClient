//
//  NotificationsRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import Foundation

protocol NotificationsRepository {
    func fetch(completion: @escaping(Result<[EventNotification], Error>) -> Void)
}
