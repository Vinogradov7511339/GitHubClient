//
//  IssueDetailsViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit

class IssueDetailsViewController: UIViewController {
    
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

    private let layoutFactory = CompositionalLayoutFactory()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutFactory.layout)
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
