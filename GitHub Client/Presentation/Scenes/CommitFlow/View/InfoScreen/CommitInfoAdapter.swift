//
//  CommitInfoAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 28.08.2021.
//

import UIKit

protocol CommitInfoAdapter: UITableViewDataSource {
    func register(_ tableView: UITableView)
    func update(with commit: Commit)
}

enum CommitInfoSectionType: Int, CaseIterable {
    case author
    case message
    case parentCommit

    var title: String {
        switch self {
        case .author:
            return "Author"
        case .message:
            return "Message"
        case .parentCommit:
            return "Parent commit"
        }
    }
}

final class CommitInfoAdapterImpl: NSObject {

    private var commit: Commit?
    private let cellManagers: [CommitInfoSectionType: TableCellManager] = [
        .author: TableCellManager.create(cellType: CommitInfoAuthorCell.self),
        .message: TableCellManager.create(cellType: CommitInfoMessageCell.self),
        .parentCommit: TableCellManager.create(cellType: CommitInfoParentCell.self)
    ]
}

// MARK: - CommitInfoAdapter
extension CommitInfoAdapterImpl: CommitInfoAdapter {
    func register(_ tableView: UITableView) {
        cellManagers.values.forEach { $0.register(tableView: tableView) }
    }

    func update(with commit: Commit) {
        self.commit = commit
    }
}

// MARK: - UITableViewDataSource
extension CommitInfoAdapterImpl {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard commit != nil else { return 0 }
        return CommitInfoSectionType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let commit = commit else { return UITableViewCell() }
        guard let sectionType = CommitInfoSectionType(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        guard let cellManager = cellManagers[sectionType] else {
            return UITableViewCell()
        }
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: commit)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        CommitInfoSectionType(rawValue: section)?.title
    }
}
