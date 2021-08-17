//
//  NotificationsViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

class EventsViewController: UIViewController {

    private var viewModel: EventsViewModel!
    private lazy var adapter: EventsAdapter = {
        EventsAdapterImpl()
    }()

    private let layoutFactory = CompositionalLayoutFactory()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutFactory.layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        collectionView.dataSource = adapter
        return collectionView
    }()

    static func create(with viewModel: EventsViewModel) -> EventsViewController {
        let viewController = EventsViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        title = "Events"
        navigationController?.navigationBar.prefersLargeTitles = false
        let image = UIImage(named: "filter_24pt")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(filterTapped))
        navigationItem.rightBarButtonItem = button

        adapter.register(collectionView: collectionView)
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    @objc func filterTapped() {
        let viewController = EventsFilterViewController()
        viewController.delegate = self
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true, completion: nil)
    }
}

// MARK: - Binding
private extension EventsViewController {
    func bind(to viewModel: EventsViewModel) {
        viewModel.events.observe(on: self) { [weak self] in self?.updateItems($0) }
    }

    func updateItems(_ events: [Event]) {
        adapter.update(events)
        collectionView.reloadData()
    }
}

extension EventsViewController: EventsFilterDelegate {
    func applyFilters(types: [EventFilterType]) {
        viewModel.apply(filters: types)
    }
}

// MARK: - UICollectionViewDelegate
extension EventsViewController: UICollectionViewDelegate {

}

private extension EventsViewController {
    func setupViews() {
        view.addSubview(collectionView)
    }

    func activateConstraints() {
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}
