//
//  ExploreViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

final class ExploreViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: ExploreViewModel) -> ExploreViewController {
        let viewController = ExploreViewController()
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
        searchController.searchResultsUpdater = viewModel.searchResultsViewModel
        searchController.searchBar.delegate = viewModel.searchResultsViewModel
        return searchController
    }()

    private lazy var searchResultController: SearchResultViewController = {
        let controller = SearchResultViewController.create(with: viewModel.searchResultsViewModel)
        return controller
    }()

    private lazy var headerView: ExploreWidgetsHeaderView = {
        let view = ExploreWidgetsHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Private variables

    private var viewModel: ExploreViewModel!

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

// MARK: - Actions
extension ExploreViewController {
    @objc func openFilter() {
        viewModel.openFilter()
    }
}

// MARK: - Binding
private extension ExploreViewController {

    func bind(to viewModel: ExploreViewModel) {
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
        viewModel.popularTitle.observe(on: self) { [weak self] in self?.updatePopularTitle($0) }
        viewModel.popular.observe(on: self) { [weak self] in self?.update($0) }
    }

    func update(_ popular: [Repository]) {
        adapter.update(popular)
        collectionView.reloadData()
    }

    func updatePopularTitle(_ newTitle: String) {
        headerView.configure(with: newTitle, handler: viewModel.openPopularSettings)
    }

    func showError(_ error: Error?) {
        guard let error = error else { return }
        let alert = ErrorAlertView.create(with: error, reloadHandler: viewModel.reload)
        alert.show(in: view)
    }
}

// MARK: - UICollectionViewDelegate
extension ExploreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }
}

// MARK: - Setup views
private extension ExploreViewController {
    func setupViews() {
        view.addSubview(headerView)
        view.addSubview(collectionView)
    }

    func activateConstraints() {
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 60.0).isActive = true

        collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    func configureNavBar() {
        title = NSLocalizedString("Explore", comment: "")
        navigationItem.searchController = searchController
        let filter = UIBarButtonItem(image: .filter,
                                       style: .plain,
                                       target: self,
                                       action: #selector(openFilter))
        navigationItem.setRightBarButton(filter, animated: false)
    }
}
