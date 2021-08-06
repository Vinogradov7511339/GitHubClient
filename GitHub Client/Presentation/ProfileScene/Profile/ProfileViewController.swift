//
//  ProfileViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.07.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    private var viewModel: ProfileViewModel!

    static func create(with viewModel: ProfileViewModel) -> ProfileViewController {
        let viewController = ProfileViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        navigationController?.navigationBar.isHidden = true

        viewModel.cellManager.register(tableView: tableView)
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    @objc func refresh(_ sender: AnyObject) {
        viewModel.refresh()
    }

    @objc func openSettings(_ sender: AnyObject) {
        let settingController = SettingsGeneralViewController()
        navigationController?.pushViewController(settingController, animated: true)
    }

    @objc func share(_ sender: AnyObject) {
        viewModel.share()
    }
}

// MARK: - Binding
private extension ProfileViewController {
    func bind(to viewModel: ProfileViewModel) {}
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemGroupedBackground
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        print(yOffset)
//        headerView.constraints.filter { $0.firstAttribute == .height }.forEach { $0.constant = 300.0 - yOffset }
    }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.tableItems.value.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableItems.value[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableItem = viewModel.tableItems.value[indexPath.section][indexPath.row]
        let cell = viewModel.cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: tableItem)
        return cell
    }
}

// MARK: - setup views
private extension ProfileViewController {
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(tableView)
        containerView.addSubview(headerView)
    }

    func activateConstraints() {
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

        headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true

        tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
}
