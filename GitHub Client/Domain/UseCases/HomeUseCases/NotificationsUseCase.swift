//
//  NotificationsUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import Foundation

protocol NotificationsUseCase {

    typealias NotificationsHandler = NotificationsRepository.NotificationsHandler
    func fetch(_ page: Int, completion: @escaping NotificationsHandler)
}

final class NotificationsUseCaseImpl {

    private let repository: NotificationsRepository

    init(repository: NotificationsRepository) {
        self.repository = repository
    }
}

// MARK: - NotificationsUseCase
extension NotificationsUseCaseImpl: NotificationsUseCase {
    func fetch(_ page: Int, completion: @escaping NotificationsHandler) {
        let filter = NotificationsFilter(perPage: 10)
        let model = NotificationsRequestModel(page: page, filter: filter)
        repository.fetch(model, completion: completion)
    }
}
