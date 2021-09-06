//
//  HomeViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.09.2021.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: HomeViewModel) -> HomeViewController {
        let viewController = HomeViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
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

    private lazy var widgetsView: WidgetsView = {
        let view = WidgetsView()
        return view
    }()

    private lazy var favoritesView: FavoritesView = {
        let view = FavoritesView()
        return view
    }()

    private lazy var eventsView: HomeEventsView = {
        let view = HomeEventsView()
        return view
    }()

    // MARK: - Private variables

    private var viewModel: HomeViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        title = NSLocalizedString("Home", comment: "")

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

// MARK: - Binding
private extension HomeViewController {
    func bind(to viewModel: HomeViewModel) {
        viewModel.widgetsState.observe(on: self) { [weak self] in self?.widgetsView.updateState($0) }
        viewModel.favoritesState.observe(on: self) { [weak self] in self?.favoritesView.updateState($0) }
        viewModel.lastEventsState.observe(on: self) { [weak self] in self?.eventsView.updateState($0) }
    }
}

// MARK: - Setup views
private extension HomeViewController {
    func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        stackView.addArrangedSubview(widgetsView)
        stackView.addArrangedSubview(favoritesView)
        stackView.addArrangedSubview(eventsView)
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
    }
}
