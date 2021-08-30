//
//  RepositoryActivityAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 29.08.2021.
//

import UIKit

enum RepositoryActivitySectionType: Int, CaseIterable {
    case actions
    case activity

    var title: String {
        switch self {
        case .actions:
            return NSLocalizedString("Actions", comment: "")
        case .activity:
            return NSLocalizedString("Last events", comment: "")
        }
    }
}

enum RepositoryActionsRowType: Int, CaseIterable {
    case sources
    case commits
    case branches
    case issues
    case pullRequests
    case releases
}

protocol RepositoryActivityAdapter: UITableViewDataSource {
    func register(_ tableView: UITableView)
    func update(_ repository: RepositoryDetails)
}

final class RepositoryActivityAdapterImpl: NSObject {
    private var repository: RepositoryDetails?
    private let actionsCellManager = TableCellManager.create(cellType: RepositoryActionCell.self)
}

// MARK: - RepositoryActivityAdapter
extension RepositoryActivityAdapterImpl: RepositoryActivityAdapter {
    func register(_ tableView: UITableView) {
        actionsCellManager.register(tableView: tableView)
    }

    func update(_ repository: RepositoryDetails) {
        self.repository = repository
    }
}

// MARK: - UITableViewDataSource
extension RepositoryActivityAdapterImpl {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard repository != nil else { return 0 }
        return RepositoryInfoSectionType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard repository != nil else { return 0 }
        let sectionType = RepositoryActivitySectionType(rawValue: section)
        switch sectionType {
        case .actions:
            return RepositoryActionsRowType.allCases.count
        case .activity:
            return 0 // return repository.events.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard repository != nil else { return UITableViewCell() }
        let sectionType = RepositoryActivitySectionType(rawValue: indexPath.section)
        switch sectionType {
        case .actions:
            guard let rowType = RepositoryActionsRowType(rawValue: indexPath.row) else {
                return UITableViewCell()
            }
            let cell = actionsCellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
            cell.populate(viewModel: rowType)
            return cell
        case .activity:
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        RepositoryActivitySectionType(rawValue: section)?.title
    }
}
