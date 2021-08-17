//
//  HomeAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 17.08.2021.
//

import UIKit

protocol HomeAdapter: UICollectionViewDataSource {
    func register(_ collectionView: UICollectionView)
    func update(_ widgets: [HomeWidget])
}

final class HomeAdapterImpl: NSObject {

    private var widgets: [HomeWidget] = []
    private var cellManager = CollectionCellManager.create(cellType: HomeWidgetCell.self)

    func update(_ widgets: [HomeWidget]) {
        self.widgets = widgets
    }
}

// MARK: - HomeAdapter
extension HomeAdapterImpl: HomeAdapter {
    func register(_ collectionView: UICollectionView) {
        cellManager.register(collectionView: collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        widgets.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let widget = widgets[indexPath.row]
        let cell = cellManager.dequeueReusableCell(collectionView: collectionView, for: indexPath)
        cell.populate(viewModel: widget)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WidgetsHeaderView.reuseIdentifier, for: indexPath)
    }
}
