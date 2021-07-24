//
//  MyRepositoriesViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.07.2021.
//

import UIKit

class MyRepositoriesViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 60.0
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var viewModels: [Any] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let dataViewTuple = ("\(Repository.self)", TableCellManager.create(cellType: MyRepositoryTableViewCell.self))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        
        dataViewTuple.1.register(tableView: tableView)
    }
}

// MARK: - UITableViewDelegate
extension MyRepositoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MyRepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dataViewTuple.1.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: viewModels[indexPath.row])
        return cell
    }
}

private extension MyRepositoriesViewController {
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
