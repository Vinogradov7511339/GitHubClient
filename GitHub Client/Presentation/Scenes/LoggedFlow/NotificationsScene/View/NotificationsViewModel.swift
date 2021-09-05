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
    var state: Observable<ItemsSceneState<EventNotification>> { get }
}

typealias NotificationsViewModel = NotificationsViewModelInput & NotificationsViewModelOutput

final class NotificationsViewModelImpl: NotificationsViewModel {

    // MARK: - Output

    var state: Observable<ItemsSceneState<EventNotification>> = Observable(.loading)

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
}

// MARK: - Private
private extension NotificationsViewModelImpl {
    func fetch() {
        self.state.value = .loading
        useCase.fetch { result in
            switch result {
            case .success(let notifications):
                self.state.value = .loaded(items: notifications)
            case .failure(let error):
                self.state.value = .error(error: error)
            }
        }
    }
}
