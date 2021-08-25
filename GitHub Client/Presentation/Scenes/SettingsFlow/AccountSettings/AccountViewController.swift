//
//  AccountViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

final class AccountViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: AccountViewModel) -> AccountViewController {
        let viewController = AccountViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemRed, for: .normal)
        button.cornerRadius = 8.0
        button.borderWidth = 1.0
        button.borderColor = .systemBlue
        button.addTarget(self, action: #selector(logoutTouched), for: .touchUpInside)
        let title = NSLocalizedString("Logout", comment: "")
        button.setTitle(title, for: .normal)
        return button
    }()

    // MARK: - Private variables

    var viewModel: AccountViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        activateConstraints()
    }
}

// MARK: - Actions
extension AccountViewController {
    @objc func logoutTouched() {
        viewModel.logoutTouched()
    }
}

// MARK: - Setup views
private extension AccountViewController {
    func setupViews() {
        view.addSubview(logoutButton)
    }

    func activateConstraints() {
        logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0).isActive = true
        logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    }
}
