//
//  MyRepositoriesViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import UIKit

final class MyRepositoriesViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: MyRepositoriesViewModel) -> MyRepositoriesViewController {
        let viewController = MyRepositoriesViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var collectionView: UICollectionView = {
        let factory = CompositionalLayoutFactory()
        let layout = factory.layout
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        collectionView.dataSource = adapter
        return collectionView
    }()

    // MARK: - Private variables

    private var viewModel: MyRepositoriesViewModel!
    private lazy var adapter: MyRepositoriesAdapter = {
        let adapter = MyRepositoriesAdapterImpl()
        return adapter
    }()

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
private extension MyRepositoriesViewController {
    func bind(to viewModel: MyRepositoriesViewModel) {
        viewModel.title.observe(on: self) { [weak self] in self?.updateTitle($0) }
        viewModel.repositories.observe(on: self) { [weak self] in self?.updateItems($0) }
    }

    func updateTitle(_ title: String) {
        self.title = title
    }

    func updateItems(_ repositories: [Repository]) {
        adapter.update(repositories)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension MyRepositoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }
}

// MARK: - Setup Views
private extension MyRepositoriesViewController {
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
