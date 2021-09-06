//
//  WidgetsView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.09.2021.
//

import UIKit

final class WidgetsView: UIView {

    func updateState(_ newState: ItemsSceneState<HomeWidget>) {
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
        let title = NSLocalizedString("Loading Widgets", comment: "")
        loader.show(title)
    }

    func prepareLoadedState(_ widgets: [HomeWidget]) {
        loader.hide()
        fillStackView(widgets)
    }

    func prepareErrorState(_ error: Error) {}

    // MARK: - Views

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("Widgets", comment: "")
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

        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

// MARK: - Private
private extension WidgetsView {
    func fillStackView(_ widgets: [HomeWidget]) {
        stackView.erase()
        widgets.forEach { add(widget: $0) }
    }

    func add(widget: HomeWidget) {
        let view = WidgetView()
        view.configure(with: widget)
        stackView.addArrangedSubview(view)
    }
}
