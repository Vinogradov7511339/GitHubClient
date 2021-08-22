//
//  NotificationsDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import UIKit

final class NotificationsDIContainer {

    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }

    let dependencies: Dependencies

    private let notificationsFactory: NotificationsFactory

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.notificationsFactory = NotificationsFactoryImpl(dataTransferService: dependencies.apiDataTransferService)
    }

    func makeNotificationsViewController(_ actions: NotificationsActions) -> UIViewController {
        notificationsFactory.makeNotificationsViewController(actions: actions)
    }
}
