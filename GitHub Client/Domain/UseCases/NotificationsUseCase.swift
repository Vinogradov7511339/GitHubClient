//
//  NotificationsUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import Foundation

protocol NotificationsUseCase {
    func fetch(completion: @escaping(Result<[EventNotification], Error>) -> Void)
}

final class NotificationsUseCaseImpl {

    private let repository: NotificationsRepository

    init(repository: NotificationsRepository) {
        self.repository = repository
    }
}

// MARK: - NotificationsUseCase
extension NotificationsUseCaseImpl: NotificationsUseCase {
    func fetch(completion: @escaping (Result<[EventNotification], Error>) -> Void) {
        repository.fetch(completion: completion)
    }
}
