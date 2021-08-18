//
//  RepositoryAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 17.08.2021.
//

import UIKit

protocol RepositoryAdapter: UITableViewDataSource {
    func register(_ tableView: UITableView)
    func update(_ repository: RepositoryDetails)
}

final class RepositoryAdapterImpl: NSObject {

    enum SectionTypes: Int, CaseIterable {
        case header
        case info
        case code
        case readMe
    }

    private let cellManages: [SectionTypes: TableCellManager] = [
        .header: TableCellManager.create(cellType: RepositoryHeaderTableViewCell.self),
        .info: TableCellManager.create(cellType: RepositoryInfoCell.self),
        .code: TableCellManager.create(cellType: RepositoryCodeCell.self),
        .readMe: TableCellManager.create(cellType: ReadMeTableViewCell.self)
    ]

    private var repository: RepositoryDetails?
}

// MARK: - RepositoryAdapter
extension RepositoryAdapterImpl: RepositoryAdapter {
    func register(_ tableView: UITableView) {
        cellManages.values.forEach { $0.register(tableView: tableView) }
    }

    func update(_ repository: RepositoryDetails) {
        self.repository = repository
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        SectionTypes.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = SectionTypes(rawValue: indexPath.section) else {
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

private extension RepositoryAdapterImpl {
    func numberOfRows(in section: Int) -> Int {
        guard let _ = repository else { return 0 }
        guard let type = SectionTypes(rawValue: section) else { return 0 }
        switch type {
        case .header: return 1
        case .info: return infoSections()
        case .code: return 2
        case .readMe: return 1
        }
    }

    func infoSections() -> Int {
        guard let repository = repository else { return 0 }
        var itemsCount = 0
        if repository.repository.hasIssues {
            itemsCount += 1
        }
        itemsCount += 1 // pull requests
        itemsCount += 1 // releases
        itemsCount += 1 // license
        return itemsCount
    }

    func viewModel(_ indexPath: IndexPath) -> Any? {
        guard let repository = repository else { return nil }
        guard let type = SectionTypes(rawValue: indexPath.section) else { return nil }
        switch type {
        case .header:
            return RepositoryDetailsHeaderCellViewModel(repository: repository.repository)
        case .info:
            if let type = RepositoryInfoCellViewModel.CellType(rawValue: indexPath.row) {
                return RepositoryInfoCellViewModel(type: type, repository: repository.repository)
            } else {
                return nil
            }
        case .code:
            if let type = RepositoryCodeCellViewModel.CellType(rawValue: indexPath.row) {
                return RepositoryCodeCellViewModel(type: type)
            } else {
                return nil
            }
        case .readMe:
            return ReadMeCellViewModel(mdText: repository.mdText)
        }
    }
}
