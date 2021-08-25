//
//  ExploreWidgetsHeaderView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.08.2021.
//

import UIKit

final class ExploreWidgetsHeaderView: UICollectionReusableView {

    // MARK: - Views

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 19.0)
        label.textAlignment = .left
        return label
    }()

    private lazy var configureButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.link, for: .normal)
        let title = NSLocalizedString("Change", comment: "")
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
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

    // MARK: - Private variables

    var handler: (() -> Void)?

    private func completeInit() {
        backgroundColor = .systemGroupedBackground
        addSubview(titleLabel)
        addSubview(configureButton)

        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        configureButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
        configureButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    // MARK: - Configure

    func configure(with title: String, handler: @escaping () -> Void) {
        titleLabel.text = title
        self.handler = handler
    }

    // MARK: - Actions

    @objc func buttonTapped() {
        handler?()
    }
}
