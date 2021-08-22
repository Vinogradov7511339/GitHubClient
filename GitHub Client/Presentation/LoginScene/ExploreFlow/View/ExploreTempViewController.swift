//
//  ExploreTempViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

final class ExploreTempViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: ExploreTempViewModel) -> ExploreTempViewController {
        let viewController = ExploreTempViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var collectionView: UICollectionView = {
        let layout = ExploreLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout.layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.dataSource = adapter
        collectionView.delegate = self
        return collectionView
    }()

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchResultsUpdater = searchResultController
        return searchController
    }()

    private lazy var searchResultController: SearchResultViewController = {
        let controller = SearchResultViewController()
        return controller
    }()

    // MARK: - Private variables

    private var viewModel: ExploreTempViewModel!

    private lazy var adapter: ExploreAdapter = {
        let adapter = ExploreAdapterImpl()
        return adapter
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        activateConstraints()
        configureNavBar()
        adapter.register(collectionView)

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

// MARK: - Binding
private extension ExploreTempViewController {

    func bind(to viewModel: ExploreTempViewModel) {
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
        viewModel.popular.observe(on: self) { [weak self] in self?.update($0) }
    }

    func update(_ popular: [Repository]) {
        adapter.update(popular)
        collectionView.reloadData()
    }

    func showError(_ error: Error?) {
        guard let error = error else { return }
        let alert = ErrorAlertView.create(with: error)
        alert.show(in: view)
    }
}

// MARK: - UICollectionViewDelegate
extension ExploreTempViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }
}

// MARK: - Setup views
private extension ExploreTempViewController {
    func setupViews() {
        view.addSubview(collectionView)
    }

    func activateConstraints() {
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    func configureNavBar() {
        title = NSLocalizedString("Explore", comment: "")
        navigationItem.searchController = searchController
    }
}
