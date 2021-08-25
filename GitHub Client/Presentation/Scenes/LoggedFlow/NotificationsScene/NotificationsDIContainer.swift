//
//  NotificationsDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import UIKit

final class NotificationsDIContainer {

    // MARK: - Dependencies

    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }

    // MARK: - Private variables

    private let dependencies: Dependencies
    private let notificationsFactory: NotificationsFactory

    init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
        self.notificationsFactory = NotificationsFactoryImpl(dataTransferService: dependencies.apiDataTransferService)
    }
}

// MARK: - NotificationsFlowCoordinatorDelegate
extension NotificationsDIContainer: NotificationsFlowCoordinatorDelegate {
    func notificationsViewController(_ actions: NotificationsActions) -> UIViewController {
        notificationsFactory.makeNotificationsViewController(actions: actions)
    }
}
