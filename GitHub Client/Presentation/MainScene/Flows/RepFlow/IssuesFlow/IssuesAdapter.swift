//
//  IssuesAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

protocol IssuesAdapter: UICollectionViewDataSource {
    func update(_ issues: [Issue])
}

final class IssuesAdapterImpl: NSObject {

    private var issues: [Issue] = []
    private let cellManager: CollectionCellManager

    init(cellManager: CollectionCellManager) {
        self.cellManager = cellManager
    }

    func update(_ issues: [Issue]) {
        self.issues = issues
    }
}

// MARK: - IssuesAdapter
extension IssuesAdapterImpl: IssuesAdapter {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        issues.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let user = issues[indexPath.row]
        let cell = cellManager.dequeueReusableCell(collectionView: collectionView, for: indexPath)
        cell.populate(viewModel: user)
        return cell
    }
}
