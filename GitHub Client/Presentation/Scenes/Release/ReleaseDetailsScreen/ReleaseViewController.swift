//
//  ReleaseViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.09.2021.
//

import UIKit

final class ReleaseViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: ReleaseViewModel) -> ReleaseViewController {
        let viewController = ReleaseViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        return tableView
    }()

    // MARK: - Private variables

    private var viewModel: ReleaseViewModel!
    private let cellManager = TableCellManager.create(cellType: ReleaseHeaderCell.self)
    private var release: Release?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        cellManager.register(tableView: tableView)

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

// MARK: - Binding
private extension ReleaseViewController {
    func bind(to viewModel: ReleaseViewModel) {
        viewModel.title.observe(on: self) { [weak self] in self?.updateTitle($0) }
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateTitle(_ newTitle: String) {
        self.title = newTitle
    }

    func updateState(_ newState: DetailsScreenState<Release>) {
        switch newState {
        case .loading:
            prepareLoadingState()
        case .error(let error):
            prepareErrorState(with: error)
        case .loaded(let release):
            prepareLoadedState(release)
        }
    }

    func prepareLoadingState() {
        tableView.isHidden = true
        hideError()
        showLoader()
    }

    func prepareErrorState(with error: Error) {
        tableView.isHidden = true
        hideLoader()
        showError(error, reloadCompletion: viewModel.refresh)
    }

    func prepareLoadedState(_ release: Release) {
        tableView.isHidden = false
        hideLoader()
        hideError()

        self.release = release
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ReleaseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        release == nil ? 0 : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let release = release else {
            return UITableViewCell()
        }
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: release)
        return cell
    }
}

// MARK: - Setup views
private extension ReleaseViewController {
    func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(tableView)
    }

    func activateConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
