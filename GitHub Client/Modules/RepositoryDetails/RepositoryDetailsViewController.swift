//
//  RepositoryDetailsViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.07.2021.
//

import UIKit

class RepositoryDetailsViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    var presenter: RepositoryPresenterInput?
    
    private let dataViewMap: [String: TableCellManager] = [
        "\(RepositoryDetailsHeaderCellViewModel.self)" : TableCellManager.create(cellType: RepositoryDetailsHeaderTableViewCell.self),
        "\(TableCellViewModel.self)" : TableCellManager.create(cellType: TableViewCell.self),
        "\(ReadMeCellViewModel.self)" : TableCellManager.create(cellType: ReadMeTableViewCell.self),
    ]
    
    private var viewModels: [[Any]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        
//        navigationController?.navigationBar.prefersLargeTitles = true
        
        dataViewMap.forEach { $0.value.register(tableView: tableView) }
        presenter?.viewDidLoad()
    }
}

// MARK: - RepositoryPresenterOutput
extension RepositoryDetailsViewController: RepositoryPresenterOutput {
    func display(viewModels: [[Any]]) {
        self.viewModels = viewModels
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension RepositoryDetailsViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension RepositoryDetailsViewController: UITableViewDataSource {
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
}

// MARK: - private
private extension RepositoryDetailsViewController {
    func cellManager(for viewModel: Any) -> TableCellManager? {
        let key = "\(type(of: viewModel))"
        let cellManager = dataViewMap[key]
        return cellManager
    }
}

// MARK: - setup views
private extension RepositoryDetailsViewController {
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
