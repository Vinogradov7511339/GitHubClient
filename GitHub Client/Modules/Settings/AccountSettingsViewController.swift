//
//  SettingsAccountViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

class AccountSettingsViewController: UIViewController {
    
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
    private var userAccounts: [String] = ["Sashko"]
    
    private lazy var editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.edit(_:)))
    private lazy var doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.done(_:)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        
        title = "Accounts"
        
        self.navigationItem.rightBarButtonItem  = editButton
        
        cellManager.register(tableView: tableView)
    }
    
    @objc func edit(_ sender: AnyObject) {
        tableView.setEditing(true, animated: true)
        self.navigationItem.rightBarButtonItem = doneButton
        
    }
    
    @objc func done(_ sender: AnyObject) {
        tableView.setEditing(false, animated: true)
        self.navigationItem.rightBarButtonItem  = editButton
    }
    
    private func changeSelectedCell(selectedAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
}

extension AccountSettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return indexPath.row <= userAccounts.count ? .delete : .none
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row <= userAccounts.count
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

extension AccountSettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userAccounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        
        let viewModel = TableCellViewModel(text: userAccounts[indexPath.row])
        cell.populate(viewModel: viewModel)
        
        return cell
    }
}

// MARK: - setup views
private extension AccountSettingsViewController {
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


