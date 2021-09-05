//
//  NotificationsViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

class NotificationsViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: NotificationsViewModel) -> NotificationsViewController {
        let viewController = NotificationsViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

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

    // MARK: - Private variables

    private var viewModel: NotificationsViewModel!
    private lazy var adapter: NotificationsAdapter = {
        let adapter = NotificationsAdapterImpl()
        return adapter
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        adapter.register(collectionView: collectionView)

        title = NSLocalizedString("Notifications", comment: "")
        navigationController?.navigationBar.prefersLargeTitles = false

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    @objc func refresh() {
        viewModel.refresh()
    }
}

// MARK: - Binding
extension NotificationsViewController {
    func bind(to viewModel: NotificationsViewModel) {
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateState(_ newState: ItemsSceneState<EventNotification>) {
        switch newState {
        case .error(let error):
            prepareErrorState(with: error)
        case .loading:
            prepareLoadingState()
        case .loaded(let items):
            prepareLoadedState(items)
        }
    }

    func prepareErrorState(with error: Error) {
        collectionView.isHidden = true
        hideLoader()
        showError(error, reloadCompletion: viewModel.refresh)
    }

    func prepareLoadingState() {
        collectionView.isHidden = true
        hideError()
        showLoader()
    }

    func prepareLoadedState(_ events: [EventNotification]) {
        collectionView.isHidden = false
        refreshControl.endRefreshing()
        hideLoader()
        hideError()
        adapter.update(events)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension NotificationsViewController: UICollectionViewDelegate {}

// MARK: - Setup views
private extension NotificationsViewController {
    func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(collectionView)
    }

    func activateConstraints() {
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
