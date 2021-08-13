//
//  CommitsViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

final class CommitsViewController: UIViewController {

    class TempLayout: UICollectionViewFlowLayout {

        override func prepare() {
            super.prepare()
            guard let collectionView = collectionView else { return }

            let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
            let cellWidth = availableWidth

            self.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.5)
            self.sectionInset = UIEdgeInsets(top: 0, left: 16.0, bottom: 0, right: 16.0)
            self.sectionInsetReference = .fromSafeArea
        }
    }

    static func create(with viewModel: CommitsViewModel) -> CommitsViewController {
        let viewController = CommitsViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    private lazy var adapter: CommitsAdapter = {
        CommitsAdapterImpl(cellManager: cellManager)
    }()

    private var viewModel: CommitsViewModel!
    private let cellManager = CollectionCellManager.create(cellType: CommitCell.self)

    private lazy var collectionView: UICollectionView = {
        let layout = TempLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        collectionView.dataSource = adapter
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        cellManager.register(collectionView: collectionView)
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

// MARK: - Binding
private extension CommitsViewController {
    func bind(to viewModel: CommitsViewModel) {
        viewModel.commits.observe(on: self) { [weak self] in self?.updateItems($0)}
    }

    func updateItems(_ commits: [Commit]) {
        adapter.update(commits)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension CommitsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }
}

// MARK: - Setup Views
private extension CommitsViewController {
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


