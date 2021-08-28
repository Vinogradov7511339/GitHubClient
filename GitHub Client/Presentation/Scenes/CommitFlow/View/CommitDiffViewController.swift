//
//  CommitDiffViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 28.08.2021.
//

import UIKit

final class CommitDiffViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: CommitViewModel) -> CommitDiffViewController {
        let viewController = CommitDiffViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Private variables

    private var viewModel: CommitViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        bind(to: viewModel)
    }
}

// MARK: - Binding
private extension CommitDiffViewController {
    func bind(to viewModel: CommitViewModel) {
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateState(_ newState: CommitScreenState) {
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
    }
}

// MARK: - Setup views
private extension CommitDiffViewController {
    func setupViews() {
        view.backgroundColor = .systemGroupedBackground
    }

    func activateConstraints() {}
}
