//
//  DeveloperSettingsViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.07.2021.
//

import UIKit

class DeveloperSettingsViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let cellManager = TableCellManager.create(cellType: TableViewCell.self)
    private var items: [String] = ["URLCache Usage: \(URLCache.shared.currentMemoryUsage)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        
        title = "Developer"
        
        cellManager.register(tableView: tableView)
    }
}

extension DeveloperSettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        URLCache.shared.removeAllCachedResponses()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //todo confirm alert
            ApplicationPresenter.shared.logout()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Sign out"
    }
}

extension DeveloperSettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        
        let viewModel = TableCellViewModel(text: items[indexPath.row])
        cell.populate(viewModel: viewModel)
        
        return cell
    }
}

// MARK: - setup views
private extension DeveloperSettingsViewController {
    func setupViews() {
        view.addSubview(tableView)
    }

    func activateConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}


