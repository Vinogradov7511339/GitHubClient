//
//  SettingsViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.07.2021.
//

import UIKit

class SettingsGeneralViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    let viewModel = SettingsViewModel()
    
    private let cellManager = TableCellManager.create(cellType: TableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        
        title = "Settings"
        cellManager.register(tableView: tableView)
    }
}

// MARK: - UITableViewDelegate
extension SettingsGeneralViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            openAppearanceViewController()
        case (0, 1):
            openChangeAppIconViewController()
        case (0, 2):
            openLanguageSettings()
        case (2, 0):
            openAccountSetttings()
        default:
            break
        }
    }
}

// MARK: - UITableViewDataSource
extension SettingsGeneralViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModel.items[indexPath.section][indexPath.row]
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: viewModel)
        return cell
    }
}

// MARK: - Routing
private extension SettingsGeneralViewController {
    func openAppearanceViewController() {
        let viewController = SettingAppearanceViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openChangeAppIconViewController() {
        let viewController = SettingsAppIconViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openLanguageSettings() {
        if let settingUrl = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingUrl)
        }
    }
    
    func openAccountSetttings() {
        let viewController = AccountSettingsViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - setup views
private extension SettingsGeneralViewController {
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
