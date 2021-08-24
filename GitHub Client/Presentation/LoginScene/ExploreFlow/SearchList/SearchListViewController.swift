//
//  SearchListViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.08.2021.
//

import UIKit

final class SearchListViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: SearchListViewModel) -> SearchListViewController {
        let viewController = SearchListViewController()
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
        collectionView.dataSource = adapter
        collectionView.delegate = self
        return collectionView
    }()

    private lazy var adapter: SearchListAdapter = {
        let type = viewModel.type
        let adapter = SearchListAdapterImpl(type: type)
        return adapter
    }()

    // MARK: - Private variables

    private var viewModel: SearchListViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        adapter.register(collectionView)

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

// MARK: - Binding
private extension SearchListViewController {
    func bind(to viewModel: SearchListViewModel) {
        viewModel.items.observe(on: self) { [weak self] in self?.updateItems($0) }
        viewModel.detailTitle.observe(on: self) { [weak self] in self?.updateTitle($0) }
    }

    func updateItems(_ newItems: [Any]) {
        adapter.update(newItems)
        collectionView.reloadData()
    }

    func updateTitle(_ detailTitle: (String, String)) {
        navigationItem.titleView = setTitle(title: detailTitle.0, subtitle: detailTitle.1)
    }
}

// MARK: - UICollectionViewDelegate
extension SearchListViewController: UICollectionViewDelegate {

}

// MARK: - Setup views
private extension SearchListViewController {
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
