//
//  RepositoryDetailsViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.07.2021.
//

import UIKit

class RepositoryViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    var presenter: RepositoryPresenterInput?

    private let dataViewMap: [String: TableCellManager] = [
        "\(RepositoryDetailsHeaderCellViewModel.self)": TableCellManager.create(cellType: RepositoryHeaderTableViewCell.self),
        "\(TableCellViewModel.self)": TableCellManager.create(cellType: TableViewCell.self),
        "\(ReadMeCellViewModel.self)": TableCellManager.create(cellType: ReadMeTableViewCell.self)
    ]

    private var viewModels: [[Any]] = [[]]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        dataViewMap.forEach { $0.value.register(tableView: tableView) }
        presenter?.viewDidLoad()
    }
}

// MARK: - RepositoryPresenterOutput
extension RepositoryViewController: RepositoryPresenterOutput {
    func display(viewModels: [[Any]]) {
        self.viewModels = viewModels
        tableView.reloadData()
    }
    
    func push(to viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension RepositoryViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource
extension RepositoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viewModel = viewModels[indexPath.section][indexPath.row]
        guard let cellManager = cellManager(for: viewModel) else {
            assert(false, "unknown viewModel \(viewModel) at \(indexPath)")
            return UITableViewCell()
        }

        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 72.0 : 20.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (0, 0): return UITableView.automaticDimension
        case (2, 0): return UITableView.automaticDimension
        default: return 56.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectRow(at: indexPath)
    }
}

// MARK: - private
private extension RepositoryViewController {
    func cellManager(for viewModel: Any) -> TableCellManager? {
        let key = "\(type(of: viewModel))"
        let cellManager = dataViewMap[key]
        return cellManager
    }
}

// MARK: - setup views
private extension RepositoryViewController {
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
