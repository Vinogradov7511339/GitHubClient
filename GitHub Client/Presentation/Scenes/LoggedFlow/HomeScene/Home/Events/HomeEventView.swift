//
//  HomeEventView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.09.2021.
//

import UIKit

final class HomeEventView: UIView {

    func configure(_ event: Event) {
        titleLabel.attributedText = event.fullTitle
        createdAtLabel.text = event.createdAt.timeAgoDisplay()
        imageView.image = event.image
    }

    // MARK: - Views

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .opaqueSeparator
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private lazy var createdAtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14.0)
        return label
    }()

    private lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .opaqueSeparator
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
        backgroundColor = .systemBackground
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(createdAtLabel)
        addSubview(separator)

        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 12.0).isActive = true
        imageView.leadingAnchor.constraint(
            equalTo: leadingAnchor, constant: 12.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 16.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 16.0).isActive = true

        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        titleLabel.leadingAnchor.constraint(
            equalTo: imageView.trailingAnchor, constant: 4.0).isActive = true
        titleLabel.trailingAnchor.constraint(
            equalTo: trailingAnchor, constant: -12.0).isActive = true

        createdAtLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0).isActive = true
        createdAtLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        createdAtLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.0).isActive = true

        separator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separator.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separator.leadingAnchor.constraint(
            equalTo: titleLabel.leadingAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
    }
}
