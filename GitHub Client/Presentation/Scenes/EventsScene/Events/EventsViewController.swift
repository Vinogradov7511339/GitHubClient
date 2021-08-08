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
        
        tableView.isHidden = true
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
