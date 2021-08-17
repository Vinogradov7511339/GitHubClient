//
//  WidgetsHeaderView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 17.08.2021.
//

import UIKit

final class WidgetsHeaderView: UICollectionReusableView {

    static let reuseIdentifier = "header-reuse-identifier"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let title = NSLocalizedString("Widgets", comment: "")
        label.text = title
        label.font = .boldSystemFont(ofSize: 22.0)
        label.textAlignment = .left
        return label
    }()

    private lazy var configureButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.link, for: .normal)
        let title = NSLocalizedString("Configure", comment: "")
        button.setTitle(title, for: .normal)
        return button
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
        addSubview(titleLabel)
        addSubview(configureButton)

        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        configureButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        configureButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
