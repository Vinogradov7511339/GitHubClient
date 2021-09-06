//
//  FavoritesView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.09.2021.
//

import UIKit

final class FavoritesView: UIView {

    func updateState(_ newState: ItemsSceneState<Repository>) {
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
        let title = NSLocalizedString("Loading favorites", comment: "")
        loader.show(title)
    }

    func prepareLoadedState(_ repositories: [Repository]) {}

    func prepareErrorState(_ error: Error) {}


    // MARK: - Views

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("Favorites", comment: "")
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
        backgroundColor = .yellow
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
