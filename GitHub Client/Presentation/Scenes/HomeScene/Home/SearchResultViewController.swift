//
//  SearchResultViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    enum State {
        case typing(text: String)
        case empty
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.delegate = self
        tableView.dataSource = self
    
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private lazy var emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()

    var text: String = "" {
        didSet {
            if !text.isEmpty {
                state = .typing(text: text)
            } else {
                state = .empty
            }
        }
    }

    private var recentSearches: [String] = []
    private lazy var searchingViewModels: [SearchTypeCellViewModel] = models()
    private let cellManager = TableCellManager.create(cellType: SearchTypeTableViewCell.self)
    
    private var state: State = .empty {
        didSet {
            stateDidChanged()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        
        cellManager.register(tableView: tableView)
    }

    private func stateDidChanged() {
        switch state {
        case .empty:
            emptyView.isHidden = !recentSearches.isEmpty
            tableView.isHidden = recentSearches.isEmpty
        case .typing(_):
            emptyView.isHidden = true
            tableView.isHidden = false
        }
        tableView.reloadData()
    }

    private func models() -> [SearchTypeCellViewModel] {
        return [
            SearchTypeCellViewModel(image: UIImage.issue, baseText: "Repositories with "),
            SearchTypeCellViewModel(image: UIImage.issue, baseText: "Issues with "),
            SearchTypeCellViewModel(image: UIImage.pullRequest, baseText: "Pull Requests with "),
            SearchTypeCellViewModel(image: UIImage.issue, baseText: "People with "),
            SearchTypeCellViewModel(image: UIImage.issue, baseText: "Organizations with "),
            SearchTypeCellViewModel(image: UIImage.issue, baseText: "Jump to ")
        ]
    }
}

// MARK: - UISearchResultsUpdating
extension SearchResultViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if !searchController.isActive {
            return
        }
        text = searchController.searchBar.searchTextField.text ?? ""
    }
}

// MARK: - UITableViewDelegate
extension SearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter?.didSelectItem(at: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension SearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .empty: return recentSearches.count
        case .typing(_): return searchingViewModels.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .typing(let text):
            var viewModel = searchingViewModels[indexPath.row]
            viewModel.text = "\(viewModel.baseText)\"\(text)\""
            let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
            cell.populate(viewModel: viewModel)
            return cell
        case .empty:
            return UITableViewCell()
        }
    }
}

// MARK: - setup views
private extension SearchResultViewController {
    func setupViews() {
        view.addSubview(emptyView)
        view.addSubview(tableView)
    }

    func activateConstraints() {
        emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        emptyView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
