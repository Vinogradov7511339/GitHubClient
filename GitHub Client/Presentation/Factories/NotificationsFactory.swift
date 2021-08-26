//
//  NotificationsFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import UIKit

protocol NotificationsFactory {
    func makeNotificationsViewController(actions: NotificationsActions) -> UIViewController
}

final class NotificationsFactoryImpl {
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARRK: - NotificationsFactory
extension NotificationsFactoryImpl: NotificationsFactory {
    func makeNotificationsViewController(actions: NotificationsActions) -> UIViewController {
        NotificationsViewController.create(with: makeNotificationsViewModel(actions: actions))
    }
}

private extension NotificationsFactoryImpl {
    func makeNotificationsViewModel(actions: NotificationsActions) -> NotificationsViewModel {
        NotificationsViewModelImpl(useCase: makeNotificationsUseCase(), actions: actions)
    }

    func makeNotificationsUseCase() -> NotificationsUseCase {
        NotificationsUseCaseImpl(repository: makeNotificationsRepository())
    }

    func makeNotificationsRepository() -> NotificationsRepository {
        NotificationsRepositoryImpl(dataTransferService: dataTransferService)
    }
}
