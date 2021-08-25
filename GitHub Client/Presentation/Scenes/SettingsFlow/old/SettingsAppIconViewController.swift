//
//  SettingsAppIconViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.07.2021.
//

import UIKit

class SettingsAppIconViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = 75.0
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private let viewModels: [TableCellViewModel] = [
        TableCellViewModel(text: "Default", detailText: nil, image: UIImage(named: "AppIcon"), imageTintColor: nil, accessoryType: .checkmark),
        TableCellViewModel(text: "Pink Light", detailText: nil, image: UIImage(named: "AppIconPinkLight"), imageTintColor: nil, accessoryType: .checkmark),
        TableCellViewModel(text: "Octocat Gray", detailText: nil, image: UIImage(named: "octocat_gray"), imageTintColor: nil, accessoryType: .checkmark)
    ]
    
    private let iconNames = ["AppIcon", "AppIconPinkLight", "octocat_gray"]
    private var selectedIconName = UIApplication.shared.alternateIconName ?? "AppIcon"
    
    private let cellManager = TableCellManager.create(cellType: TableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        title = "App Icon"
        cellManager.register(tableView: tableView)
    }
    
    private func changeSelectedCell(selectedAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        if let index = iconNames.firstIndex(of: selectedIconName) {
            tableView.cellForRow(at: IndexPath(row: index, section: indexPath.section))?.accessoryType = .none
        }
    }
}

extension SettingsAppIconViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let iconName = iconNames[indexPath.row]
        if iconName == selectedIconName {
            return
        }
        UIApplication.shared.setAlternateIconName(iconName) { error in
            if let error = error {
                print("error \(error)")
            } else {
                self.changeSelectedCell(selectedAt: indexPath)
                self.selectedIconName = iconName
            }
        }
    }
}

extension SettingsAppIconViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: viewModel)
        
        let iconName = iconNames[indexPath.row]
        if iconName == selectedIconName {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}

// MARK: - setup views
private extension SettingsAppIconViewController {
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


