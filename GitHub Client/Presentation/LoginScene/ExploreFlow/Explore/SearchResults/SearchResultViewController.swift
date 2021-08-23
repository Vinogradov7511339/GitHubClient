//
//  SearchResultViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

class SearchResultViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: SearchResultViewModel) -> SearchResultViewController {
        let viewController = SearchResultViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = searchAdapter
        return tableView
    }()

    private lazy var resultsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = resultsAdapter
        return tableView
    }()
    
    private lazy var emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()

    // MARK: - Private variables

    private var viewModel: SearchResultViewModel!

    private lazy var searchAdapter: SearchAdapter = {
        let adapter = SearchAdapterImpl()
        return adapter
    }()

    private lazy var resultsAdapter: ResultsAdapter = {
        let adapter = ResultsAdapterImpl()
        return adapter
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        searchAdapter.register(searchTableView)
        resultsAdapter.register(resultsTableView)

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

// MARK: - Binding
private extension SearchResultViewController {
    func bind(to viewModel: SearchResultViewModel) {
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateState(_ state: SearchState) {
        switch state {
        case .empty:
            emptyView.isHidden = false
            searchTableView.isHidden = true
            resultsTableView.isHidden = true

        case .results(let result):
            resultsAdapter.update(result)
            resultsTableView.isHidden = false
            emptyView.isHidden = true
            searchTableView.isHidden = true

        case .typing(let text):
            searchAdapter.update(text)
            emptyView.isHidden = true
            searchTableView.isHidden = false
            resultsTableView.isHidden = true
        }
        resultsTableView.reloadData()
        searchTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension SearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if tableView === searchTableView {
            viewModel.didSelectSearchItem(at: indexPath)
        } else if tableView === resultsTableView {
            viewModel.didSelectResultItem(at: indexPath)
        }
    }
}

// MARK: - setup views
private extension SearchResultViewController {
    func setupViews() {
        view.addSubview(emptyView)
        view.addSubview(searchTableView)
        view.addSubview(resultsTableView)
    }

    func activateConstraints() {
        emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        emptyView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        resultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        resultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        resultsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        resultsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
