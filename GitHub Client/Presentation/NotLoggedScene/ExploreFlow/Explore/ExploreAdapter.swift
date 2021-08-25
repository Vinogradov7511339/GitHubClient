//
//  ExploreAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

protocol ExploreAdapter: UICollectionViewDataSource {
    func register(_ collectionView: UICollectionView)
    func update(_ popular: [Repository])
}

final class ExploreAdapterImpl: NSObject {

    private var popular: [Repository] = []
    private let cellManager = CollectionCellManager.create(cellType: PopularRepCell.self)
}

// MARK: - ExploreAdapter
extension ExploreAdapterImpl: ExploreAdapter {
    func register(_ collectionView: UICollectionView) {
        cellManager.register(collectionView: collectionView)
    }

    func update(_ popular: [Repository]) {
        self.popular = popular
    }
}

// MARK: - UICollectionViewDataSource
extension ExploreAdapterImpl {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        popular.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let repository = popular[indexPath.row]
        let cell = cellManager.dequeueReusableCell(collectionView: collectionView, for: indexPath)
        cell.populate(viewModel: repository)
        return cell
    }
}
