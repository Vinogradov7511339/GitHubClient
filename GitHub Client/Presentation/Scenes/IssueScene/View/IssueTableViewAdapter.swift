//
//  IssueTableViewAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import UIKit

protocol IssueTableViewAdapter: UICollectionViewDataSource {
    func register(collectionView: UICollectionView)
    func update(_ comments: [Comment])
}

final class IssueTableViewAdapterImpl: NSObject {
    private let issue: Issue
    private var comments: [Comment] = []
    private let headerCellManager = CollectionCellManager.create(cellType: IssueHeaderCell.self)
    private let commentCellManager = CollectionCellManager.create(cellType: CommentCell.self)

    init(issue: Issue) {
        self.issue = issue
    }
}

// MARK: - IssueTableViewAdapter
extension IssueTableViewAdapterImpl: IssueTableViewAdapter {
    func update(_ comments: [Comment]) {
        self.comments = comments
    }

    func register(collectionView: UICollectionView) {
        headerCellManager.register(collectionView: collectionView)
        commentCellManager.register(collectionView: collectionView)
    }
}

// MARK: - UITableViewDataSource
extension IssueTableViewAdapterImpl {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 0 ? 1 : comments.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BaseCollectionViewCell
        if indexPath.section == 0 {
            cell = headerCellManager.dequeueReusableCell(collectionView: collectionView, for: indexPath)
            cell.populate(viewModel: issue)
        } else {
            cell = commentCellManager.dequeueReusableCell(collectionView: collectionView, for: indexPath)
            cell.populate(viewModel: comments[indexPath.row])
        }
        return cell
    }
}
