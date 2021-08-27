//
//  PRAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

enum PRSectionType: Int, CaseIterable {
    case prInfo
    case comment
}

enum PRHeaderCellType: Int {
    case header
}

protocol PRAdapter: UITableViewDataSource {
    func register(_ tableView: UITableView)
    func update(with header: PullRequestDetails, comments: [Comment])
}

final class PRAdapterImpl: NSObject {
    private var header: PullRequestDetails?
    private var comments: [Comment] = []
    private let commentCellManager = TableCellManager.create(cellType: PRCommentCell.self)
    private let prInfoCellManagers: [PRHeaderCellType: TableCellManager] = [
        .header: TableCellManager.create(cellType: PRHeaderCell.self)
    ]
}

// MARK: - PRAdapter
extension PRAdapterImpl: PRAdapter {
    func register(_ tableView: UITableView) {
        commentCellManager.register(tableView: tableView)
        prInfoCellManagers.values.forEach { $0.register(tableView: tableView) }
    }

    func update(with header: PullRequestDetails, comments: [Comment]) {
        self.header = header
        self.comments = comments
    }
}

// MARK: - UITableViewDataSource
extension PRAdapterImpl {
    func numberOfSections(in tableView: UITableView) -> Int {
        PRSectionType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = PRSectionType(rawValue: section) else { return 0 }
        switch sectionType {
        case .prInfo:
            guard let header = header else { return 0 }
            return header.cells.count
        case .comment:
            return comments.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let header = header else {
            return UITableViewCell()
        }
        guard let sectionType = PRSectionType(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch sectionType {
        case .prInfo:
            let type = header.cells[indexPath.row]
            if let cellManager = prInfoCellManagers[type] {
                let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
                cell.populate(viewModel: header)
                return cell
            } else {
                return UITableViewCell()
            }
        case .comment:
            let comment = comments[indexPath.row]
            let cell = commentCellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
            cell.populate(viewModel: comment)
            return cell
        }
    }
}

private extension PullRequestDetails {
    var cells: [PRHeaderCellType] {
        return [.header]
    }
}
