//
//  EventsFilterViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.08.2021.
//

import UIKit

protocol EventsFilterDelegate: AnyObject {
    func applyFilters(types: [EventFilterType])
}

final class EventsFilterViewController: UIViewController {

    weak var delegate: EventsFilterDelegate?

    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.cornerRadius = 32.0
        return view
    }()

    private lazy var bgButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        return button
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "xmark")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("Events Filter", comment: "")
        label.font = .boldSystemFont(ofSize: 16.0)
        return label
    }()

    private lazy var filtersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.cornerRadius = 8.0
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        let title = NSLocalizedString("Apply", comment: "")
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(applyTapped), for: .touchUpInside)
        return button
    }()

    private var filters: [EventFilterViewModel] = EventFilterType.allCases
        .map { EventFilterViewModel(type: $0, isSelected: false) }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        view.backgroundColor = .black.withAlphaComponent(0.1)

        filters.forEach {
            let view = EventFilterView.create(with: $0, actionListener: changeFilterSelectedState)
            filtersStackView.addArrangedSubview(view)
            view.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        }
    }

    func changeFilterSelectedState(_ viewModel: EventFilterViewModel) {
        filters.removeAll(where: { $0.type == viewModel.type} )
        filters.append(viewModel)
    }

    @objc func closeTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc func applyTapped() {
        let apply = filters.filter { $0.isSelected }.map { $0.type }
        delegate?.applyFilters(types: apply)
        dismiss(animated: true, completion: nil)
    }
}

private extension EventsFilterViewController {
    func setupViews() {
        view.addSubview(bgButton)
        view.addSubview(container)
        container.addSubview(closeButton)
        container.addSubview(titleLabel)
        container.addSubview(filtersStackView)
        container.addSubview(applyButton)
    }

    func activateConstraints() {
        bgButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bgButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bgButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bgButton.bottomAnchor.constraint(equalTo: container.topAnchor).isActive = true

        container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0).isActive = true
        container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
        container.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16.0).isActive = true

        titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.0).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true

        closeButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.0).isActive = true
        closeButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.0).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 24.0).isActive = true

        filtersStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8.0).isActive = true
        filtersStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8.0).isActive = true
        filtersStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16.0).isActive = true
        filtersStackView.bottomAnchor.constraint(equalTo: applyButton.topAnchor, constant: -16.0).isActive = true

        applyButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.0).isActive = true
        applyButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.0).isActive = true
        applyButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16.0).isActive = true
        applyButton.heightAnchor.constraint(equalToConstant: 42.0).isActive = true
    }
}
