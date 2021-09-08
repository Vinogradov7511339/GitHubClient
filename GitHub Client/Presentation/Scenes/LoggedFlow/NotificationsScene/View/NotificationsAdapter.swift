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
}

// MARK: - NotificationsAdapter
extension NotificationsAdapterImpl: NotificationsAdapter {
    func update(_ notifications: [EventNotification]) {
        self.notifications = notifications
    }

    func register(collectionView: UICollectionView) {
        cellManager.register(collectionView: collectionView)
    }
}

// MARK: - UICollectionViewDataSource
extension NotificationsAdapterImpl {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notifications.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = notifications[indexPath.row]
        let cell = cellManager.dequeueReusableCell(collectionView: collectionView, for: indexPath)
        cell.populate(viewModel: item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let collectionView = collectionView as? CollectionView else {
            return CollectionFooterView()
        }
        return collectionView.collectionView(kind, at: indexPath)
    }
}
