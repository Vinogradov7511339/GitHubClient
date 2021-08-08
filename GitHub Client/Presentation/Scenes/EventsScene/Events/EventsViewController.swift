//
//  NotificationsViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

class EventsViewController: UIViewController {

    private var viewModel: EventsViewModel!

    static func create(with viewModel: EventsViewModel) -> EventsViewController {
        let viewController = EventsViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    private lazy var emptyView: NotificationsEmptyView = {
        let view = NotificationsEmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        
        title = "Events"
        navigationController?.navigationBar.prefersLargeTitles = false

        viewModel.cellManager.register(tableView: tableView)
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

// MARK: - Binding
private extension EventsViewController {
    func bind(to viewModel: EventsViewModel) {
        viewModel.events.observe(on: self) { [weak self] _ in self?.updateItems() }
    }

    func updateItems() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension EventsViewController: UITableViewDelegate {

}

// MARK: - UITableViewDataSource
extension EventsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.events.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.events.value[indexPath.row]
        let cell = viewModel.cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: item)
        return cell
    }
}

private extension EventsViewController {
    func setupViews() {
        view.addSubview(emptyView)
        view.addSubview(tableView)
    }

    func activateConstraints() {
        emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        emptyView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}
