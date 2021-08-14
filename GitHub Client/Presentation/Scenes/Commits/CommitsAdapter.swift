//
//  CommitsAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

protocol CommitsAdapter: UICollectionViewDataSource {
    func update(_ commits: [ExtendedCommit])
}

final class CommitsAdapterImpl: NSObject {

    private var commits: [ExtendedCommit] = []
    private let cellManager: CollectionCellManager

    init(cellManager: CollectionCellManager) {
        self.cellManager = cellManager
    }

    func update(_ commits: [ExtendedCommit]) {
        self.commits = commits
    }
}

// MARK: - IssuesAdapter
extension CommitsAdapterImpl: CommitsAdapter {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        commits.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let user = commits[indexPath.row]
        let cell = cellManager.dequeueReusableCell(collectionView: collectionView, for: indexPath)
        cell.populate(viewModel: user)
        return cell
    }
}
