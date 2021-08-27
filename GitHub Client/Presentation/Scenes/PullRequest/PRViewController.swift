//
//  PRViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

final class PRViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: PRViewModel) -> PRViewController {
        let viewController = PRViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Private variables

    private var viewModel: PRViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

// MARK: - Binding
private extension PRViewController {
    func bind(to viewModel: PRViewModel) {
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateState(_ newState: PRScreenState) {
        switch newState {
        case .error(let error):
            prepareErrorState(with: error)
        case .loading:
            prepareLoadingState()
        case .loaded(let model):
            prepareLoadedState(model)
        }
    }

    func prepareLoadingState() {
        hideError()
        showLoader()
    }

    func prepareErrorState(with error: Error) {
        hideLoader()
        showError(error, reloadCompletion: viewModel.refresh)
    }

    func prepareLoadedState(_ model: PullRequestDetails) {
        hideError()
        hideLoader()
    }
}

// MARK: - Setup views
private extension PRViewController {
    func setupViews() {
        view.backgroundColor = .systemGroupedBackground
    }

    func activateConstraints() {}
}
