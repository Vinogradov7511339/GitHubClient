//
//  IssueDetailsViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit

class IssueDetailsViewController: UIViewController {

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
    
    private var viewModel: IssueViewModel!

    private lazy var adapter: IssueTableViewAdapter = {
        let adapter = IssueTableViewAdapterImpl(issue: viewModel.issue)
        return adapter
    }()

    static func create(with viewModel: IssueViewModel) -> IssueDetailsViewController {
        let viewController = IssueDetailsViewController()
        viewController.viewModel = viewModel
        return viewController
    }

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
        adapter.register(collectionView: collectionView)
        bind(to: viewModel)
        navigationController?.navigationBar.prefersLargeTitles = false

        viewModel.viewDidLoad()
    }
}

// MARK: - Binding
private extension IssueDetailsViewController {
    func bind(to viewModel: IssueViewModel) {
        viewModel.comments.observe(on: self) { [weak self] in self?.update($0) }
    }

    func update(_ comments: [Comment]) {
        adapter.update(comments)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension IssueDetailsViewController: UICollectionViewDelegate {}

// MARK: - setup views
private extension IssueDetailsViewController {
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
