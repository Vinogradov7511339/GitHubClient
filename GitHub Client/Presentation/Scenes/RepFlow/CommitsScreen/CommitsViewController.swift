//
//  CommitsViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

final class CommitsViewController: UIViewController {

    class TempLayout: UICollectionViewFlowLayout {

        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            let layoutAttributesObjects = super.layoutAttributesForElements(in: rect)?.map{ $0.copy() } as? [UICollectionViewLayoutAttributes]
            layoutAttributesObjects?.forEach({ layoutAttributes in
                if layoutAttributes.representedElementCategory == .cell {
                    if let newFrame = layoutAttributesForItem(at: layoutAttributes.indexPath)?.frame {
                        layoutAttributes.frame = newFrame
                    }
                }
            })
            return layoutAttributesObjects
        }

        override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
            guard let collectionView = collectionView else { fatalError() }
            guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else {
                return nil
            }

            layoutAttributes.frame.origin.x = sectionInset.left
            layoutAttributes.frame.size.width = collectionView.safeAreaLayoutGuide.layoutFrame.width - sectionInset.left - sectionInset.right
            return layoutAttributes
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

    private lazy var layout: TempLayout = {
        let layout = TempLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 8.0, right: 16.0)
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
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

    func updateItems(_ commits: [ExtendedCommit]) {
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


