//
//  NotificationsViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

class NotificationsViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: NotificationsViewModel) -> NotificationsViewController {
        let viewController = NotificationsViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var collectionView: CollectionView = {
//        let layoutFactory = CompositionalLayoutFactory()
//        let layout = layoutFactory.layout
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let collectionView = CollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        collectionView.dataSource = adapter
        collectionView.refreshControl = refreshControl
        return collectionView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()

    private var nextPageLoadingSpinner: UIActivityIndicatorView?

    // MARK: - Private variables

    private var viewModel: NotificationsViewModel!
    private lazy var adapter: NotificationsAdapter = {
        let adapter = NotificationsAdapterImpl()
        return adapter
    }()
    private var items: [EventNotification] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        adapter.register(collectionView: collectionView)

        title = NSLocalizedString("Notifications", comment: "")
        navigationController?.navigationBar.prefersLargeTitles = false

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    @objc func refresh() {
        viewModel.refresh()
    }
}

// MARK: - Binding
extension NotificationsViewController {
    func bind(to viewModel: NotificationsViewModel) {
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateState(_ newState: ItemsSceneState<EventNotification>) {
        switch newState {
        case .error(let error):
            prepareErrorState(with: error)
        case .loading:
            prepareLoadingState()
        case .loaded(let items, let paths):
            prepareLoadedState(items, paths: paths)
        case .loadingNext:
            collectionView.showBottomIndicator()
        case .refreshing:
            refreshControl.beginRefreshing()
        }
    }

    func prepareErrorState(with error: Error) {
        collectionView.isHidden = true
        hideLoader()
        showError(error, reloadCompletion: viewModel.refresh)
    }

    func prepareLoadingState() {
        collectionView.isHidden = true
        hideError()
        showLoader()
    }

    func prepareLoadedState(_ events: [EventNotification], paths: [IndexPath]) {
        collectionView.isHidden = false
        self.items = events
        refreshControl.endRefreshing()
        hideLoader()
        hideError()
        adapter.update(events)
        collectionView.insertItems(at: paths)
        collectionView.hideBottomIndicator()
//        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension NotificationsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == items.count - 1 {
            viewModel.loadNext()
        }
    }
}

// MARK: - Setup views
private extension NotificationsViewController {
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

public class CollectionFooterView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CollectionView: UICollectionView {

     let bottomIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)

    init() {
        let layoutFactory = CompositionalLayoutFactory()
        let layout = layoutFactory.layout
        super.init(frame: .zero, collectionViewLayout: layout)
        completeInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        completeInit()
    }

    private func completeInit() {
        register(CollectionFooterView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: "Footer")
    }

    func showBottomIndicator() {
        bottomIndicator.startAnimating()
    }

    func hideBottomIndicator() {
        bottomIndicator.stopAnimating()
    }

    func collectionView(_ kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let footer = dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: "Footer",
                for: indexPath) as? CollectionFooterView else {
            return CollectionFooterView()
        }
        footer.addSubview(bottomIndicator)
        bottomIndicator.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 50)
        return footer
    }
}
