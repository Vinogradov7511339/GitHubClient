//
//  SettingAppearanceViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.07.2021.
//

import UIKit

class SettingAppearanceViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private let userStyles: [UIUserInterfaceStyle] = [.unspecified, .dark, .light]
    private var styleNames = ["Automatic", "Dark", "Light"]
    private var selectedStyle: UIUserInterfaceStyle = .unspecified
    
    private let cellManager = TableCellManager.create(cellType: TableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        
        title = "App Icon"
        selectedStyle = view.overrideUserInterfaceStyle
        
        cellManager.register(tableView: tableView)
    }
    
    private func changeSelectedCell(selectedAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        if let index = userStyles.firstIndex(of: selectedStyle) {
            tableView.cellForRow(at: IndexPath(row: index, section: indexPath.section))?.accessoryType = .none
        }
    }
}

extension SettingAppearanceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let newStyle = userStyles[indexPath.row]
        if newStyle == selectedStyle {
            return
        }
        view.window?.overrideUserInterfaceStyle = newStyle
        changeSelectedCell(selectedAt: indexPath)
        selectedStyle = newStyle
    }
}

extension SettingAppearanceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userStyles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        
        let viewModel = TableCellViewModel(text: styleNames[indexPath.row])
        cell.populate(viewModel: viewModel)
        
        let iconName = userStyles[indexPath.row]
        if iconName == selectedStyle {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}

// MARK: - setup views
private extension SettingAppearanceViewController {
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


