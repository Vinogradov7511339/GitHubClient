//
//  ExploreCollectionViewLayout.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

struct NotificationsActions {}

protocol NotificationsViewModelInput {
    func viewDidLoad()
    func refresh()
}

protocol NotificationsViewModelOutput: AnyObject {
    var notifications: Observable<[EventNotification]> { get }
}

typealias NotificationsViewModel = NotificationsViewModelInput & NotificationsViewModelOutput

final class NotificationsViewModelImpl: NotificationsViewModel {

    // MARK: - Output

    var notifications: Observable<[EventNotification]> = Observable([])

    // MARK: - Private
    private let useCase: NotificationsUseCase
    private let actions: NotificationsActions

    init(useCase: NotificationsUseCase, actions: NotificationsActions) {
        self.useCase = useCase
        self.actions = actions
    }
}

// MARK: - Input
extension NotificationsViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func refresh() {
        fetch()
    }

    func handle(_ error: Error) {}
}

// MARK: - Private
private extension NotificationsViewModelImpl {
    func fetch() {
        useCase.fetch { result in
            switch result {
            case .success(let notifications):
                self.notifications.value = notifications
            case .failure(let error):
                self.handle(error)
            }
        }
    }
}
