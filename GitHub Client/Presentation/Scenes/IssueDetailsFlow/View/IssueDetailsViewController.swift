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
        let adapter = IssueTableViewAdapterImpl()
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
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateState(_ newState: IssueScreenState) {
        switch newState {
        case .loading:
            prepareLoadingState()
        case .error(let error):
            prepareErrorState(with: error)
        case .loaded(let issue, let comments):
            prepareLoadedState(issue, comments)
        }
    }

    func prepareLoadingState() {
        collectionView.isHidden = true
        hideError()
        showLoader()
    }

    func prepareErrorState(with error: Error) {
        collectionView.isHidden = true
        hideLoader()
        showError(error, reloadCompletion: viewModel.refresh)
    }

    func prepareLoadedState(_ issue: Issue, _ comments: [Comment]) {
        collectionView.isHidden = false
        hideLoader()
        hideError()
        adapter.update(issue, comments: comments)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension IssueDetailsViewController: UICollectionViewDelegate {}

// MARK: - setup views
private extension IssueDetailsViewController {
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
