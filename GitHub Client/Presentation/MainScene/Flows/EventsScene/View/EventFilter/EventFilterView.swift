//
//  EventFilterView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.08.2021.
//

import UIKit

enum EventFilterType: String, CaseIterable {
    case all = "All"
//    case commitCommentEvent = "Commit Comment Events"
    case createEvent = "Create Events"
//    case deleteEvent = "Delete Events"
//    case forkEvent = "Fork Events"
//    case gollumEvent = "Gollum Events"
    case issueCommentEvent = "Issue Comment Events"
//    case issuesEvent = "Issues Eventa"
//    case memberEvent = "Member Events"
//    case publicEvent = "Public Events"
//    case pullRequestEvent = "Pull Request Events"
//    case pullRequestReviewEvent = "Pull Request Review Events"
//    case pullRequestReviewCommentEvent = "Pull Request Review Comment Events"
    case pushEvent = "Push Events"
//    case releaseEvent = "Release Events"
//    case sponsorshipEvent = "Sponsorship Events"
    case watchEvent = "Watch Events"
}

struct EventFilterViewModel {
    let type: EventFilterType
    var isSelected: Bool
}

final class EventFilterView: UIView {

    static func create(with viewModel: EventFilterViewModel, actionListener: @escaping (EventFilterViewModel) -> ()) -> EventFilterView {
        let view = EventFilterView()
        view.viewModel = viewModel
        view.listener = actionListener
        view.configure(with: viewModel)
        return view
    }

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var filterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var selectionStateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .opaqueSeparator.withAlphaComponent(0.5)
        return view
    }()

    private lazy var bgButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(viewTapped), for: .touchUpInside)
        return button
    }()

    private func configure(with viewModel: EventFilterViewModel) {
        filterNameLabel.text = viewModel.type.rawValue
        let imageName = viewModel.isSelected ? "selected_circle" : "empty_circle"
        let image = UIImage(named: imageName)
        selectionStateImageView.image = image
        let tintColor: UIColor = viewModel.isSelected ? .systemGreen : .secondaryLabel
        selectionStateImageView.tintColor = tintColor
    }

    private var viewModel: EventFilterViewModel!

    @objc func viewTapped() {
        viewModel.isSelected = !viewModel.isSelected
        changeImageState()
        listener?(viewModel)
    }

    private func changeImageState() {
        let imageName = viewModel.isSelected ? "selected_circle" : "empty_circle"
        let image = UIImage(named: imageName)
        let tintColor: UIColor = viewModel.isSelected ? .systemGreen : .secondaryLabel
        UIView.transition(with: selectionStateImageView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.selectionStateImageView.image = image
                            self.selectionStateImageView.tintColor = tintColor
                          }, completion: nil)
    }

    var listener: ((EventFilterViewModel) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        completionInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        completionInit()
    }

    private func completionInit() {
        addSubview(imageView)
        addSubview(filterNameLabel)
        addSubview(selectionStateImageView)
        addSubview(separator)
        addSubview(bgButton)

        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24.0).isActive = true

        filterNameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8.0).isActive = true
        filterNameLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true

        selectionStateImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
        selectionStateImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        selectionStateImageView.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        selectionStateImageView.heightAnchor.constraint(equalToConstant: 24.0).isActive = true

        separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        separator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        bgButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bgButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bgButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bgButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
