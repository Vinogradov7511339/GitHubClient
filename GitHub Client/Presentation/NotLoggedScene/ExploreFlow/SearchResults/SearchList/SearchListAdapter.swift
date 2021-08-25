//
//  SearchListAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.08.2021.
//

import UIKit

protocol SearchListAdapter: UICollectionViewDataSource {
    func register(_ collectionView: UICollectionView)
    func update(_ items: [Any])
}

final class SearchListAdapterImpl: NSObject {

    private let cellManager: CollectionCellManager
    private var items: [Any] = []

    init(type: SearchType) {
        switch type {
        case .repositories:
            cellManager = CollectionCellManager.create(cellType: RepositoryItemCell.self)
        case .issues:
            cellManager = CollectionCellManager.create(cellType: RepositoryItemCell.self)
        case .pullRequests:
            cellManager = CollectionCellManager.create(cellType: RepositoryItemCell.self)
        case .people:
            cellManager = CollectionCellManager.create(cellType: UserCell.self)
        }
    }
}

// MARK: - SearchListAdapter
extension SearchListAdapterImpl: SearchListAdapter {
    func register(_ collectionView: UICollectionView) {
        cellManager.register(collectionView: collectionView)
    }

    func update(_ items: [Any]) {
        self.items = items
    }
}

// MARK: - UICollectionViewDataSource
extension SearchListAdapterImpl {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
