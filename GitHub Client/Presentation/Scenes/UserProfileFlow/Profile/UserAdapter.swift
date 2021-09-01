//
//  UserAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.08.2021.
//

import UIKit

enum UserSectionType: Int, CaseIterable {
    case header
    case info
    case activity
    case actions

    var numberOfRows: Int {
        switch self {
        case .header:
            return 1
        case .info:
            return 1
        case .activity:
            return 1
        case .actions:
            return UserActionsRowType.allCases.count
        }
    }
}

enum UserActionsRowType: Int, CaseIterable {
    case repositories
    case starred
    case gists
    case events
}

protocol UserAdapter: UITableViewDataSource {
    func register(_ tableView: UITableView)
    func update(_ profile: UserProfile)
}

final class UserAdapterImpl: NSObject {
    private var userProfile: UserProfile?
    private let cellManagers: [UserSectionType: TableCellManager] = [
        .header: TableCellManager.create(cellType: UserHeaderCell.self),
        .info: TableCellManager.create(cellType: UserInfoCell.self),
        .activity: TableCellManager.create(cellType: UserActivityCell.self),
        .actions: TableCellManager.create(cellType: UserActionCell.self)
    ]

    weak var delegate: UserHeaderCellDelegate?

    init(headerDelegate: UserHeaderCellDelegate?) {
        delegate = headerDelegate
    }
}

// MARK: - UserAdapter
extension UserAdapterImpl: UserAdapter {
    func register(_ tableView: UITableView) {
        cellManagers.values.forEach { $0.register(tableView: tableView) }
    }

    func update(_ profile: UserProfile) {
        self.userProfile = profile
    }
}

// MARK: - UITableViewDataSource
extension UserAdapterImpl {
    func numberOfSections(in tableView: UITableView) -> Int {
        UserSectionType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UserSectionType(rawValue: section)?.numberOfRows ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = UserSectionType(rawValue: indexPath.section) else { return UITableViewCell() }
        guard let cellManager = cellManagers[sectionType] else { return UITableViewCell() }
        guard let viewModel = viewModel(for: indexPath) else { return UITableViewCell() }
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        if let headerCell = cell as? UserHeaderCell {
            headerCell.delegate = delegate
        }
        cell.populate(viewModel: viewModel)
        return cell
    }

    func viewModel(for indexPath: IndexPath) -> Any? {
        guard let sectionType = UserSectionType(rawValue: indexPath.section) else { return nil }
        switch sectionType {
        case .header:
            return userProfile
        case .info:
            return userProfile
        case .activity:
            return userProfile
        case .actions:
            return UserActionsRowType(rawValue: indexPath.row)
        }
    }
}
