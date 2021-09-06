//
//  FavoritesEmptyView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.09.2021.
//

import UIKit

final class FavoritesEmptyView: UIView {

    // MARK: - Views

    private var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.cornerRadius = 12.0
        view.backgroundColor = .systemBackground
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = Const.title
        return label
    }()

    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let title = NSLocalizedString("Add Favorites", comment: "")
        button.setTitle(title, for: .normal)
        button.setTitleColor(button.tintColor, for: .normal)
        button.cornerRadius = 8.0
        button.borderWidth = 1.0
        button.borderColor = button.tintColor
        return button
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
        addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(addButton)

        container.topAnchor.constraint(equalTo: topAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0).isActive = true
        container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0).isActive = true
        container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.0).isActive = true

        titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 12.0).isActive = true
        titleLabel.leadingAnchor.constraint(
            equalTo: container.leadingAnchor, constant: 12.0).isActive = true
        titleLabel.trailingAnchor.constraint(
            equalTo: container.trailingAnchor, constant: -12.0).isActive = true

        addButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0).isActive = true
        addButton.leadingAnchor.constraint(
            equalTo: container.leadingAnchor, constant: 12.0).isActive = true
        addButton.trailingAnchor.constraint(
            equalTo: container.trailingAnchor, constant: -12.0).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        addButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12.0).isActive = true
    }
}

// MARK: - Const
private extension FavoritesEmptyView {
    enum Const {
        static let title: String = """
Add favorite
repositories/issues/pulls/peoples here to have
quick access at any time, without having to search
"""
    }
}
