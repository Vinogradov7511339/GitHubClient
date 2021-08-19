//
//  RepViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class RepViewController: UIViewController {
    
    private var viewModel: RepViewModel!

    static func create(with viewModel: RepViewModel) -> RepViewController {
        let viewController = RepViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    private let adapter: RepositoryAdapter = RepositoryAdapterImpl()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = adapter
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        adapter.register(tableView)

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

// MARK: - Bind
private extension RepViewController {
    func bind(to viewModel: RepViewModel) {
        viewModel.repository.observe(on: self) { [weak self] in self?.updateItems($0) }
    }
    
    func updateItems(_ repository: RepositoryDetails?) {
        guard let repository = repository else { return }
        adapter.update(repository)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension RepViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.0 : 20.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        return view
    }
}

// MARK: - RepositoryHeaderTableViewCellDelegate
extension RepViewController: RepositoryHeaderTableViewCellDelegate {
    func favoritesButtonTouchUpInside() {
        viewModel.addToFavorites()
    }
}

// MARK: - setup views
private extension RepViewController {
    func setupViews() {
        view.addSubview(tableView)
    }

    func activateConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}
