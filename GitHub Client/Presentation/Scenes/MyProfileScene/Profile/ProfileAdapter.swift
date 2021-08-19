//
//  ProfileAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.08.2021.
//

import UIKit

protocol ProfileAdapter: UITableViewDataSource {
    func register(_ tableView: UITableView)
    func update(with profile: UserDetails)
}

final class ProfileAdapterImpl: NSObject {

    enum SectionTypes: Int, CaseIterable {
        case header
        case info
    }

    private let cellManages: [SectionTypes: TableCellManager] = [
        .header: TableCellManager.create(cellType: ProfileHeaderCell.self),
        .info: TableCellManager.create(cellType: ProfileItemCell.self)
    ]

    private var profile: UserDetails?
}

// MARK: - ProfileAdapter
extension ProfileAdapterImpl: ProfileAdapter {
    func register(_ tableView: UITableView) {
        cellManages.values.forEach { $0.register(tableView: tableView) }
    }

    func update(with profile: UserDetails) {
        self.profile = profile
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        SectionTypes.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = SectionTypes(rawValue: indexPath.section) else {
            assert(false, "no type")
            return BaseTableViewCell(frame: .zero)
        }
        guard let viewModel = viewModel(indexPath) else {
            assert(false, "Empty viewmodel")
            return BaseTableViewCell(frame: .zero)
        }

        let cellManager = cellManages[sectionType]
        let cell = cellManager?.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell?.populate(viewModel: viewModel)
        return cell ?? BaseTableViewCell(frame: .zero)
    }
}

private extension ProfileAdapterImpl {
    func numberOfRows(in section: Int) -> Int {
        guard profile != nil else { return 0 }
        guard let type = SectionTypes(rawValue: section) else {
            assert(false, "no type")
            return 0
        }
        switch type {
        case .header: return 1
        case .info: return ProfileItemCellViewModel.ItemType.allCases.count
        }
    }

    func viewModel(_ indexPath: IndexPath) -> Any? {
        guard let profile = profile else { return nil }
        guard let type = SectionTypes(rawValue: indexPath.section) else {
            assert(false, "no type")
            return nil
        }
        switch type {
        case .header:
            return profile
        case .info:
            switch indexPath.row {
            case 0:
                return ProfileItemCellViewModel.init(type: .repositories)
            case 1:
                return ProfileItemCellViewModel.init(type: .starred)
            case 2:
                return ProfileItemCellViewModel.init(type: .organizations)
            case 3:
                return ProfileItemCellViewModel.init(type: .subscriptions)
            default:
                return nil
            }
        }
    }
}
