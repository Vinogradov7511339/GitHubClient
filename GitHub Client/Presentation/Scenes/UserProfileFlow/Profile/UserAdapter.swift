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
    var visibleSectionTypes: [UserSectionType] { get }
    var visibleRows: [UserActionsRowType] { get }

    func register(_ tableView: UITableView)
    func update(_ profile: UserProfile)
}

final class UserAdapterImpl: NSObject {

    // MARK: - Public variables

    weak var delegate: UserHeaderCellDelegate?
    var visibleSectionTypes: [UserSectionType] = []
    var visibleRows: [UserActionsRowType] = []

    // MARK: - Private variables

    private var userProfile: UserProfile?
    private let cellManagers: [UserSectionType: TableCellManager] = [
        .header: TableCellManager.create(cellType: UserHeaderCell.self),
        .info: TableCellManager.create(cellType: UserInfoCell.self),
        .activity: TableCellManager.create(cellType: UserActivityCell.self),
        .actions: TableCellManager.create(cellType: UserActionCell.self)
    ]

    // MARK: - Lifecycle

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
        self.visibleSectionTypes = profile.sections
        self.visibleRows = profile.rows
    }
}

// MARK: - UITableViewDataSource
extension UserAdapterImpl {
    func numberOfSections(in tableView: UITableView) -> Int {
        visibleSectionTypes.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = visibleSectionTypes[section]
        switch sectionType {
        case .header, .info, .activity:
            return 1
        case .actions:
            return visibleRows.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = visibleSectionTypes[indexPath.section]
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
        let sectionType = visibleSectionTypes[indexPath.section]
        switch sectionType {
        case .header:
            return userProfile
        case .info:
            return userProfile
        case .activity:
            return userProfile
        case .actions:
            return visibleRows[indexPath.row]
        }
    }
}

private extension UserProfile {
    var sections:  [UserSectionType] {
        var sections: [UserSectionType] = []
        sections.append(.header)
        sections.append(.info)
        switch user.type {
        case .user, .bot:
            if !lastEvents.isEmpty {
                sections.append(.activity)
            }
        default:
            break
        }
        sections.append(.actions)
        return sections
    }

    var rows: [UserActionsRowType] {
        switch user.type {
        case .user, .bot:
            return [.repositories, .starred, .gists, .events]
        case .organization:
            return [.repositories]
        case .unknown:
            return []
        }
    }
}
