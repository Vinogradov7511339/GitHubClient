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

    private let cellManager = TableCellManager.create(cellType: TableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        cellManager.register(tableView: tableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        title = NSLocalizedString("Appearance", comment: "")
    }
}

extension SettingAppearanceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.visibleCells.forEach { $0.accessoryType = .none }
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        let theme = Theme(rawValue: indexPath.row)
        theme?.apply(to: view.window)
    }
}

extension SettingAppearanceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Theme.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let themeName = Theme(rawValue: indexPath.row)?.name else {
            return UITableViewCell()
        }
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        let viewModel = TableCellViewModel(text: themeName)
        cell.populate(viewModel: viewModel)

        let type: UITableViewCell.AccessoryType
        if Theme.current.rawValue == indexPath.row {
            type = .checkmark
        } else {
            type = .none
        }
        cell.accessoryType = type
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
