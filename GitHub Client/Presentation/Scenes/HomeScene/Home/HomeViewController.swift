//
//  MyWorkViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.07.2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel!

    private lazy var adapter: HomeAdapter = {
        let adapter = HomeAdapterImpl()
        return adapter
    }()

    static func create(with viewModel: HomeViewModel) -> HomeViewController {
        let viewController = HomeViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = adapter
        return tableView
    }()
    
    private lazy var resultViewController: SearchResultViewController = {
        let resultController = SearchResultViewController()
        return resultController
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: resultViewController)
        searchController.searchResultsUpdater = resultViewController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Search GitHub", comment: "")
        searchController.isActive = true
        return searchController
    }()

    private let refreshControl = UIRefreshControl()
    private var notificationObjects: [NSObjectProtocol] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        activateConstraints()
        configureNavigationBar()

        adapter.register(tableView: tableView)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        bind(to: viewModel)

        observeToNotifications()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        viewModel.viewWillAppear()
    }

    @objc func refresh(_ sender: AnyObject) {
        viewModel.refresh()
    }

    @objc func showFavorites(_ sender: AnyObject) {}
}

// MARK: - Binding
private extension HomeViewController {
    func bind(to viewModel: HomeViewModel) {
        viewModel.favorites.observe(on: self) { [weak self] in self?.updateItems($0) }
    }

    func updateItems(_ favorites: [Repository]) {
        adapter.favorites = favorites
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ? firstHeader() : secondHeader()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50.0
    }
}

// MARK: - Header views
private extension HomeViewController {
    func firstHeader() -> UIView {
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 50.0)
        let view = UIView(frame: frame)
        view.backgroundColor = .systemGroupedBackground
        let labelFrame = CGRect(x: 0, y: 10, width: view.bounds.width, height: 40)
        let label = UILabel(frame: labelFrame)
        label.font = .boldSystemFont(ofSize: 21.0)
        label.text = "My Work"
        view.addSubview(label)
        return view
    }

    func secondHeader() -> UIView {
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 50.0)
        let view = UIView(frame: frame)
        view.backgroundColor = .systemGroupedBackground
        let labelFrame = CGRect(x: 0, y: 10, width: view.bounds.width, height: 40)
        let label = UILabel(frame: labelFrame)
        label.font = .boldSystemFont(ofSize: 21.0)
        label.text = "Favorites"
        view.addSubview(label)
        let buttonFrame = CGRect(x: view.bounds.width - 100, y: 0.0, width: 100.0, height: 50.0)
        let button = UIButton.init(frame: buttonFrame)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setTitle("Edit", for: .normal)
        button.addTarget(self, action:  #selector(self.showFavorites(_:)), for: .touchUpInside)
        view.addSubview(button)
        return view
    }
}

// MARK: - Keyobard Notifications
private extension HomeViewController {
    private func observeToNotifications() {
        let notificationCenter = NotificationCenter.default
        _ = notificationCenter.addObserver(
            forName: UIResponder.keyboardWillChangeFrameNotification,
            object: nil, queue: .main) { (notification) in
            self.handleKeyboard(notification: notification)
        }
        _ = notificationCenter.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil, queue: .main) { (notification) in
            self.handleKeyboard(notification: notification)
        }
    }

    private func handleKeyboard(notification: Notification) {
        guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
            view.layoutIfNeeded()
            return
        }

        guard let info = notification.userInfo,
              let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
            return
        }

        let keyboardHeight = keyboardFrame.cgRectValue.size.height
        self.searchController.showsSearchResultsController = keyboardHeight != 0
    }
}

// MARK: - setup views
private extension HomeViewController {
    func setupViews() {
        view.addSubview(tableView)
    }

    func activateConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func configureNavigationBar() {
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }
}
