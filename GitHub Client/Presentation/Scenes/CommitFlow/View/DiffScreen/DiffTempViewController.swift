//
//  DiffTempViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.09.2021.
//

import UIKit

final class DiffTempViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: CommitViewModel) -> DiffTempViewController {
        let viewController = DiffTempViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "To see diff \nyou shoud be authorized"
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Private variables

    private var viewModel: CommitViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        bind(to: viewModel)

        switch UserStorage.shared.loginState {
        case .logged:
            stackView.isHidden = false
            loginLabel.isHidden = true
        case .notLogged:
            stackView.isHidden = true
            loginLabel.isHidden = false
        }
    }
}

// MARK: - Binding
private extension DiffTempViewController {
    func bind(to viewModel: CommitViewModel) {
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateState(_ newState: DetailsScreenState<Commit>) {
        switch newState {
        case .loading:
            prepareLoadingState()
        case .error(let error):
            prepareErrorState(error)
        case .loaded(let commit):
            prepareLoadedState(commit)
        }
    }

    func prepareLoadingState() {
        hideError()
        showLoader()
    }

    func prepareErrorState(_ error: Error) {
        hideLoader()
        showError(error, reloadCompletion: viewModel.refresh)
    }

    func prepareLoadedState(_ commit: Commit) {
        hideLoader()
        hideError()
        switch UserStorage.shared.loginState {
        case .logged:
            stackView.isHidden = false
            loginLabel.isHidden = true
            parse(commit)
        case .notLogged:
            stackView.isHidden = true
            loginLabel.isHidden = false
        }
    }

    func parse(_ commit: Commit) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let viewModels = commit.files.map { CommitDiffCellViewModel(isExpanded: true, file: $0) }
        viewModels.forEach { addFile($0) }
    }

    func addFile(_ viewModel: CommitDiffCellViewModel) {
        let view = DiffView()
        view.configure(with: viewModel)
        stackView.addArrangedSubview(view)

    }
}

// MARK: - Setup views
private extension DiffTempViewController {
    func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(loginLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
    }

    func activateConstraints() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
