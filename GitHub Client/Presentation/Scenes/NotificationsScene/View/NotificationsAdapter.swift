//
//  NotificationsAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import UIKit

protocol NotificationsAdapter: UICollectionViewDataSource {
    func register(collectionView: UICollectionView)
    func update(_ notifications: [EventNotification])
}

final class NotificationsAdapterImpl: NSObject {
    private var notifications: [EventNotification] = []

    private let cellManager = CollectionCellManager.create(cellType: NotificationCell.self)
//    private let cellManagesMap: [Event.Types: CollectionCellManager] = [
//        Event.Types.createEvent: CollectionCellManager.create(cellType: ForkEventCell.self),
//        Event.Types.pushEvent: CollectionCellManager.create(cellType: PushEventCell.self),
//        Event.Types.watchEvent: CollectionCellManager.create(cellType: ForkEventCell.self),
//        Event.Types.forkEvent: CollectionCellManager.create(cellType: ForkEventCell.self),
//        Event.Types.issueCommentEvent: CollectionCellManager.create(cellType: IssueCommentEventCell.self)
//    ]
}

// MARK: - NotificationsAdapter
extension NotificationsAdapterImpl: NotificationsAdapter {
    func update(_ notifications: [EventNotification]) {
        self.notifications = notifications
    }

    func register(collectionView: UICollectionView) {
        cellManager.register(collectionView: collectionView)
//        cellManagesMap.values.forEach { $0.register(collectionView: collectionView) }
    }
}

// MARK: - UICollectionViewDataSource
extension NotificationsAdapterImpl {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notifications.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = notifications[indexPath.row]
        let cell = cellManager.dequeueReusableCell(collectionView: collectionView, for: indexPath)
        cell.populate(viewModel: item)
        return cell
//        let event = notifications[indexPath.row]
//        let cellManager = cellManagesMap[event.eventType]
//        let cell = cellManager?.dequeueReusableCell(collectionView: collectionView, for: indexPath)
//        cell?.populate(viewModel: event)
//        return cell ?? UICollectionViewCell(frame: .zero)
    }
}

