//
//  ProfileViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.08.2021.
//

import UIKit

final class ProfileViewController: UIViewController {

    static func create(with viewModel: ProfileViewModel) -> ProfileViewController {
        let viewController = ProfileViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    private var viewModel: ProfileViewModel!

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.dataSource = adapter
        tableView.delegate = self
        return tableView
    }()

    private lazy var adapter: ProfileAdapter = {
        let adapter = ProfileAdapterImpl()
        adapter.delegate = self
        return adapter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        configureNavBar()
        adapter.register(tableView)

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    @objc func openSettings() {
        viewModel.openSettings()
    }
}

// MARK: - Binding
private extension ProfileViewController {
    func bind(to viewModel: ProfileViewModel) {
        viewModel.user.observe(on: self) { [weak self] in self?.update($0) }
    }

    func update(_ profile: UserProfile?) {
        guard let profile = profile else {
            return
        }
        adapter.update(with: profile)
        tableView.reloadData()
    }
}

// MARK: - ProfileHeaderCellDelegate
extension ProfileViewController: ProfileHeaderCellDelegate {
    func followingTouched() {
        viewModel.showFollowing()
    }

    func followersTouched() {
        viewModel.showFollowers()
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 0 ? UITableView.automaticDimension : 56.0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 1 ? 30.0 : 0.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 1 else { return nil }
        return UIView()
    }
}

private extension ProfileViewController {
    func setupViews() {
        view.addSubview(tableView)
    }

    func activateConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }

    func configureNavBar() {
        let settings = UIBarButtonItem(image: .settings, style: .plain, target: self, action: #selector(openSettings))
        navigationItem.setRightBarButton(settings, animated: false)
    }
}
