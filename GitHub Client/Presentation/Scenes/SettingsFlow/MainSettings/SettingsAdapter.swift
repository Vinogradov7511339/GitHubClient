//
//  SettingsAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

enum SettingsSection: Int, CaseIterable {
    case account
}

protocol SettingsAdapter: UITableViewDataSource {
    func register(_ tableView: UITableView)
}

final class SettingsAdapterImpl: NSObject {
        private let cellManagesMap: [SettingsSection: TableCellManager] = [
            SettingsSection.account: TableCellManager.create(cellType: AccountCell.self)
        ]

    private let user: User

    init(_ user: User) {
        self.user = user
    }
}

// MARK: - SettingsAdapter
extension SettingsAdapterImpl: SettingsAdapter {
    func register(_ tableView: UITableView) {
        cellManagesMap.values.forEach { $0.register(tableView: tableView) }
    }
}

// MARK: - UITableViewDataSource
extension SettingsAdapterImpl {

    func numberOfSections(in tableView: UITableView) -> Int {
        SettingsSection.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = SettingsSection(rawValue: section) else {
            assert(false, "no section type")
            return 0
        }
        switch sectionType {
        case .account:  return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = SettingsSection(rawValue: indexPath.section) else {
            assert(false, "no section type")
            return UITableViewCell()
        }
        let cellManager = cellManagesMap[sectionType]
        let cell = cellManager?.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell?.populate(viewModel: user)
        return cell ?? UITableViewCell()
    }
}
