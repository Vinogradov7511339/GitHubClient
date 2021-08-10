//
//  RepViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class RepViewController: UIViewController {
    
    private var viewModel: RepViewModel!

    static func create(with viewModel: RepViewModel) -> RepViewController {
        let viewController = RepViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        viewModel.adapter.register(tableView: tableView)

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

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        return view
    }
}

// MARK: - UITableViewDataSource
extension RepViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.adapter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.adapter.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.adapter.cellForRow(in: tableView, at: indexPath)
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
