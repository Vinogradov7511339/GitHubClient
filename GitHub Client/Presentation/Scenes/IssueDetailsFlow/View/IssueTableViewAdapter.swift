//
//  IssueTableViewAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import UIKit

enum IssueSectionType: Int, CaseIterable {
    case header
    case comment
}

protocol IssueTableViewAdapter: UICollectionViewDataSource {
    func register(collectionView: UICollectionView)
    func update(_ issue: Issue, comments: [Comment])
}

final class IssueTableViewAdapterImpl: NSObject {
    private var issue: Issue?
    private var comments: [Comment] = []

    private let cellManagers: [IssueSectionType: CollectionCellManager] = [
        .header:  CollectionCellManager.create(cellType: IssueHeaderCell.self),
        .comment: CollectionCellManager.create(cellType: CommentCell.self)
    ]
}

// MARK: - IssueTableViewAdapter
extension IssueTableViewAdapterImpl: IssueTableViewAdapter {
    func update(_ issue: Issue, comments: [Comment]) {
        self.issue = issue
        self.comments = comments
    }

    func register(collectionView: UICollectionView) {
        cellManagers.values.forEach { $0.register(collectionView: collectionView) }
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
    }
}

// MARK: - UITableViewDataSource
extension IssueTableViewAdapterImpl {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        IssueSectionType.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = IssueSectionType(rawValue: section)
        switch sectionType {
        case .header:
            return 1
        case .comment:
            return comments.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionType = IssueSectionType(rawValue: indexPath.section) else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
        }
        guard let cellManager = cellManagers[sectionType] else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
        }
        guard let viewModel = viewModel(for: indexPath) else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
        }
        let cell = cellManager.dequeueReusableCell(collectionView: collectionView, for: indexPath)
        cell.populate(viewModel: viewModel)
        return cell
    }
}

// MARK: - Private
private extension IssueTableViewAdapterImpl {
    func viewModel(for indexPath: IndexPath) -> Any? {
        let type = IssueSectionType(rawValue: indexPath.section)
        switch type {
        case .header:
            return issue
        case .comment:
            return comments[indexPath.row]
        default:
            return nil
        }
    }
}
