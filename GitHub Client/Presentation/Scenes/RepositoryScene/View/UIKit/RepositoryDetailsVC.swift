//
//  RepositoryDetailsVC.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

final class RepositoryDetailsVC: UIViewController {

    static func create(with viewModel: RepViewModel) -> RepositoryDetailsVC {
        let viewController = RepositoryDetailsVC()
        viewController.viewModel = viewModel
        return viewController
    }

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemGroupedBackground
        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var header: RepositoryHeaderView = {
        let view = RepositoryHeaderView.instanceFromNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()

    private var viewModel: RepViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        navigationController?.navigationBar.prefersLargeTitles = false

        stackView.addArrangedSubview(header)

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

// MARK: - Binding
private extension RepositoryDetailsVC {
    func bind(to viewModel: RepViewModel) {
        viewModel.repository.observe(on: self) { [weak self] in self?.update($0) }
    }

    func update(_ repository: RepositoryDetails?) {
        guard let repository = repository?.repository else { return }
        header.update(repository)
    }
}

// MARK: - RepositoryHeaderDelegate
extension RepositoryDetailsVC: RepositoryHeaderDelegate {
    func commitsButtonTouchUpInside() {
        viewModel.showCommits()
    }

    func pullRequestsButtonTouchUpInside() {
        viewModel.showPullRequests()
    }

    func eventsButtonTouchUpInside() {
        viewModel.showEvents()
    }

    func showIssuesButtonTouchUpIside() {
        viewModel.showIssues()
    }
}

private extension RepositoryDetailsVC {
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
    }

    func activateConstraints() {
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
}
