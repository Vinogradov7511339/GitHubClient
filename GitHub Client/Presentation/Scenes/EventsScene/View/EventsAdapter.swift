//
//  EventsAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.08.2021.
//

import UIKit

protocol EventsAdapter: UICollectionViewDataSource {
    func register(collectionView: UICollectionView)
    func update(_ events: [Event])
}

final class EventsAdapterImpl: NSObject {
    private var events: [Event] = []
    private let cellManagesMap: [Event.Types: CollectionCellManager] = [
        Event.Types.createEvent: CollectionCellManager.create(cellType: CreateEventCell.self),
        Event.Types.pushEvent: CollectionCellManager.create(cellType: PushEventCell.self),
        Event.Types.watchEvent: CollectionCellManager.create(cellType: WatchEventCell.self),
        Event.Types.issueCommentEvent: CollectionCellManager.create(cellType: IssueCommentEventCell.self)
    ]
}

// MARK: - EventsAdapter
extension EventsAdapterImpl: EventsAdapter {
    func update(_ events: [Event]) {
        self.events = events
    }

    func register(collectionView: UICollectionView) {
        cellManagesMap.values.forEach { $0.register(collectionView: collectionView) }
    }
}

// MARK: - UICollectionViewDataSource
extension EventsAdapterImpl {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        events.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let event = events[indexPath.row]
        let cellManager = cellManagesMap[event.eventType]
        let cell = cellManager?.dequeueReusableCell(collectionView: collectionView, for: indexPath)
        cell?.populate(viewModel: event)
        return cell ?? UICollectionViewCell(frame: .zero)
    }
}
