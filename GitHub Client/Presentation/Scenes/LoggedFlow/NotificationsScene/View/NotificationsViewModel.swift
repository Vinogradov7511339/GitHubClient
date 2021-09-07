//
//  ExploreCollectionViewLayout.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

struct NotificationsActions {
    let openIssue: (URL) -> Void
}

protocol NotificationsViewModelInput {
    func viewDidLoad()
    func refresh()

    func didSelectItem(at indexPath: IndexPath)
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

    func didSelectItem(at indexPath: IndexPath) {
        guard case .loaded(let items) = state.value else { return }
        let item = items[indexPath.row]
        switch item.type {
        case .issue:
            if let issueUrl = item.notification.subject.url {
                actions.openIssue(issueUrl)
            }
        case .unknown:
            break
        }
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
