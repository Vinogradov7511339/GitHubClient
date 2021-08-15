//
//  ProfileEventView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 15.08.2021.
//

import UIKit

final class ProfileEventView: UIView {

    static func create(with event: Event) -> ProfileEventView {
        let view = ProfileEventView()
        view.event = event
        view.configure()
        return view
    }

    func configure() {
        titleLabel.text = event.eventType.rawValue
        dateLabel.text = event.createdAt.timeAgoDisplay()
    }

    private var event: Event!

    private lazy var container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.cornerRadius = 8.0
        container.borderWidth = 1.0
        container.borderColor = .opaqueSeparator.withAlphaComponent(0.5)
        return container
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = .systemFont(ofSize: 14.0)
        dateLabel.textColor = .secondaryLabel
        return dateLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        completeInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        completeInit()
    }

    private func completeInit() {
        addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(dateLabel)

        container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0).isActive = true
        container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0).isActive = true
        container.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
        container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0).isActive = true

        titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 8.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8.0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8.0).isActive = true
        titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: dateLabel.leadingAnchor, constant: -4.0).isActive = true

        dateLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 8.0).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8.0).isActive = true
    }
}
