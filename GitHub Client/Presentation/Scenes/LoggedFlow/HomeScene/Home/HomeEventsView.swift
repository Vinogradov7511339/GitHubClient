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

    func prepareLoadedState(_ repositories: [Event]) {}

    func prepareErrorState(_ error: Error) {}

    // MARK: - Views

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("Last events", comment: "")
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
        backgroundColor = .green
        addSubview(titleLabel)
        addSubview(stackView)

        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0).isActive = true

        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
