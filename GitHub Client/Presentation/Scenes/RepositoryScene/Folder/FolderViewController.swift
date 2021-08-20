//
//  FolderViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

class FolderViewController: UIViewController {

    static func create(with viewModel: FolderViewModel) -> FolderViewController {
        let viewController = FolderViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    private var viewModel: FolderViewModel!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .systemGroupedBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        return tableView
    }()

    private let cellManager = TableCellManager.create(cellType: FolderCell.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        configureNavBar()
        cellManager.register(tableView: tableView)

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    @objc func openMenu() {
        let alert = UIAlertController(title: "Folder menu", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Copy Folder Path", style: .default, handler: { _ in
            self.viewModel.copyFolderPath()
        }))
        alert.addAction(UIAlertAction(title: "Share", style: .default, handler: { _ in
            self.viewModel.share()
        }))
        alert.addAction(UIAlertAction(title: "Folders Settings", style: .default, handler: { _ in
            self.viewModel.openFolderSettings()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
        }))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Binding
private extension FolderViewController {
    func bind(to viewModel: FolderViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.update() }
        viewModel.title.observe(on: self) { [weak self] in self?.update(title: $0) }
    }

    func update() {
        tableView.reloadData()
    }

    func update(title: String) {
        self.title = title
    }
}

extension FolderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
}

extension FolderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModel.items.value[indexPath.row]
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: viewModel)
        return cell
    }
}

// MARK: - setup views
private extension FolderViewController {
    func setupViews() {
        view.addSubview(tableView)
    }

    func activateConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func configureNavBar() {
        let menuButton = UIBarButtonItem(image: .menu,
                                         style: .plain,
                                         target: self,
                                         action: #selector(openMenu))
        navigationItem.setRightBarButton(menuButton, animated: true)
    }
}
