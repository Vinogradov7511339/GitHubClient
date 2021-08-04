//
//  RepViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class RepViewController: UIViewController {
    
    private var viewModel: RepViewModel!
    private let cellManager = TableCellManager.create(cellType: StarredRepoTableViewCell.self)

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    static func create(with viewModel: RepViewModel) -> RepViewController {
        let viewController = RepViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        cellManager.register(tableView: tableView)

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

// MARK: - Bind
private extension RepViewController {
    func bind(to viewModel: RepViewModel) {
//        viewModel.items.observe(on: self) { [weak self] _ in self?.updateItems() }
//        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }
    
    func updateItems() {
        tableView.reloadData()
    }
    
    func showError(_ error: String) {
        guard !error.isEmpty else { return }
        print("error: \(error)")
    }
}

// MARK: - UITableViewDelegate
extension RepViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension RepViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModel.items.value[indexPath.row]
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: viewModel)
        return cell
    }
}

// MARK: - setup views
private extension RepViewController {
    func setupViews() {
        view.addSubview(tableView)
    }

    func activateConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}
