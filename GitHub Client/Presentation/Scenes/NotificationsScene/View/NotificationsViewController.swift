//
//  ExploreViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

class ExploreViewController: UIViewController {

    static func create(with viewModel: NotificationsViewModel) -> ExploreViewController {
        let viewController = ExploreViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    private var viewModel: NotificationsViewModel!

    private lazy var adapter: NotificationsAdapter = {
        let adapter = NotificationsAdapterImpl()
        return adapter
    }()

    private lazy var collectionView: UICollectionView = {
        let layoutFactory = CompositionalLayoutFactory()
        let layout = layoutFactory.layout
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        collectionView.dataSource = adapter
        collectionView.refreshControl = refreshControl
        return collectionView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        adapter.register(collectionView: collectionView)

        title = NSLocalizedString("Notifications", comment: "")
        navigationController?.navigationBar.prefersLargeTitles = true

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    @objc func refresh() {
        viewModel.refresh()
    }
}

// MARK: - Binding
extension ExploreViewController {
    func bind(to viewModel: NotificationsViewModel) {
        viewModel.notifications.observe(on: self) { [weak self] in self?.update($0) }
    }

    func update(_ notifications: [EventNotification]) {
        adapter.update(notifications)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension ExploreViewController: UICollectionViewDelegate {}

// MARK: - setup views
private extension ExploreViewController {
    func setupViews() {
        view.addSubview(collectionView)
    }

    func activateConstraints() {
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
