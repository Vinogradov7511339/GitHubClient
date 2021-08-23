//
//  SearchAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.08.2021.
//

import UIKit

protocol SearchAdapter: UITableViewDataSource {
    func register(_ tableView: UITableView)
    func update(_ text: String)
}

final class SearchAdapterImpl: NSObject {
    private let cellManager = TableCellManager.create(cellType: SearchTypeTableViewCell.self)
    private let items: [SearchTypeCellViewModel] = [
        SearchTypeCellViewModel(image: UIImage.issue, baseText: "Repositories with "),
        SearchTypeCellViewModel(image: UIImage.issue, baseText: "Issues with "),
        SearchTypeCellViewModel(image: UIImage.pullRequest, baseText: "Pull Requests with "),
        SearchTypeCellViewModel(image: UIImage.issue, baseText: "People with "),
        SearchTypeCellViewModel(image: UIImage.issue, baseText: "Organizations with "),
        SearchTypeCellViewModel(image: UIImage.issue, baseText: "Jump to ")
    ]

    private var searchText: String = ""
}

// MARK: - SearchAdapter
extension SearchAdapterImpl: SearchAdapter {
    func register(_ tableView: UITableView) {
        cellManager.register(tableView: tableView)
    }

    func update(_ text: String) {
        self.searchText = text
    }
}

// MARK: - UITableViewDataSource
extension SearchAdapterImpl {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var viewModel = items[indexPath.row]
        viewModel.text = "\(viewModel.baseText)\"\(searchText)\""
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: viewModel)
        return cell
    }
}
