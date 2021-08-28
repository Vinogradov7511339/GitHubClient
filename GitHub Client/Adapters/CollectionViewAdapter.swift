//
//  CollectionViewAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 26.08.2021.
//

import UIKit

protocol CollectionViewAdapter: UICollectionViewDataSource {
    func register(_ collectionView: UICollectionView)
    func update(_ items: [Any])
}

final class CollectionViewAdapterImpl: NSObject {

    private let cellManager: CollectionCellManager
    private var items: [Any] = []

    init(with cellManager: CollectionCellManager) {
        self.cellManager = cellManager
    }
}

// MARK: - CollectionViewAdapter
extension CollectionViewAdapterImpl: CollectionViewAdapter {
    func register(_ collectionView: UICollectionView) {
        cellManager.register(collectionView: collectionView)
    }

    func update(_ items: [Any]) {
        self.items = items
    }
}

// MARK: - UICollectionViewDataSource
extension CollectionViewAdapterImpl {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let cell = cellManager.dequeueReusableCell(collectionView: collectionView, for: indexPath)
        cell.populate(viewModel: item)
        return cell
    }
}
