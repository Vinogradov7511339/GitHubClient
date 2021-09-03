//
//  ProfileAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.08.2021.
//

import UIKit

enum MyProfileSectionTypes: Int, CaseIterable {
    case header
    case info
    case activity
    case actions

    var numberOfRows: Int {
        switch self {
        case .header: return 1
        case .info: return 1
        case .activity: return 1
        case .actions: return MyProfileRowType.allCases.count
        }
    }
}

enum MyProfileRowType: Int, CaseIterable {
    case repositories
    case starred
    case subscriptions
}

protocol ProfileAdapter: UITableViewDataSource {
    func register(_ tableView: UITableView)
    func update(with profile: AuthenticatedUser)
}

final class ProfileAdapterImpl: NSObject {
    private var profile: AuthenticatedUser?
    private let cellManages: [MyProfileSectionTypes: TableCellManager] = [
        .header: TableCellManager.create(cellType: ProfileHeaderCell.self),
        .info: TableCellManager.create(cellType: MyProfileInfoCell.self),
        .activity: TableCellManager.create(cellType: MyProfileActivityCell.self),
        .actions: TableCellManager.create(cellType: ProfileItemCell.self)
    ]

    weak var delegate: ProfileHeaderCellDelegate?

    init(headerDelegate: ProfileHeaderCellDelegate?) {
        delegate = headerDelegate
    }
}

// MARK: - ProfileAdapter
extension ProfileAdapterImpl: ProfileAdapter {
    func register(_ tableView: UITableView) {
        cellManages.values.forEach { $0.register(tableView: tableView) }
    }

    func update(with profile: AuthenticatedUser) {
        self.profile = profile
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        MyProfileSectionTypes.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MyProfileSectionTypes(rawValue: section)?.numberOfRows ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = MyProfileSectionTypes(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        guard let viewModel = viewModel(indexPath) else {
            return UITableViewCell()
        }
        guard let cellManager = cellManages[sectionType] else { return UITableViewCell() }
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: viewModel)
        if let headerCell = cell as? ProfileHeaderCell {
            headerCell.delegate = delegate
        }
        return cell
    }
}

private extension ProfileAdapterImpl {
    func viewModel(_ indexPath: IndexPath) -> Any? {
        guard let profile = profile else { return nil }
        let type = MyProfileSectionTypes(rawValue: indexPath.section)
        switch type {
        case .header:
            return profile.userDetails
        case .info:
            return profile
        case .activity:
            return profile
        case .actions:
            return MyProfileRowType(rawValue: indexPath.row)
        default:
            return nil
        }
    }
}
