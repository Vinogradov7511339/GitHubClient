//
//  HomeEventsView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.09.2021.
//

import UIKit

final class HomeEventsView: UIView {
    func updateState(_ newState: ItemsSceneState<Event>) {
        switch newState {
        case .loading:
            prepareLoadingState()
        case .loaded(let items):
            prepareLoadedState(items)
        case .error(let error):
            prepareErrorState(error)
        }
    }

    func prepareLoadingState() {
        stackView.erase()
        stackView.addArrangedSubview(loader)
        let title = NSLocalizedString("Loading Events", comment: "")
        loader.show(title)
    }

    func prepareLoadedState(_ events: [Event]) {
        loader.hide()
        if events.isEmpty {
            stackView.addArrangedSubview(emptyView)
        } else {
            fillStackView(events)
        }
    }

    func prepareErrorState(_ error: Error) {}

    // MARK: - Views

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("Last events", comment: "")
        label.font = .systemFont(ofSize: 19.0, weight: .medium)
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var loader: LoaderView = {
        let view = LoaderView()
        return view
    }()

    private lazy var emptyView: HomeEventsEmptyView = {
        let view = HomeEventsEmptyView()
        return view
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        completeInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        completeInit()
    }

    private func completeInit() {
        addSubview(titleLabel)
        addSubview(stackView)

        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0).isActive = true

        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

// MARK: - Private
private extension HomeEventsView {
    func fillStackView(_ events: [Event]) {
        stackView.erase()
        events.forEach { add(event: $0) }
    }

    func add(event: Event) {
        let view = HomeEventView()
        view.configure(event)
        stackView.addArrangedSubview(view)
    }
}
