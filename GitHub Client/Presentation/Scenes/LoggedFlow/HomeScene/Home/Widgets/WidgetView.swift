//
//  WidgetView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.09.2021.
//

import UIKit

extension HomeWidget {
    var title: String {
        switch self {
        case .issues:
            return NSLocalizedString("Issues", comment: "")
        case .repositories:
            return NSLocalizedString("Repositories", comment: "")
        case .starredRepositories:
            return NSLocalizedString("Starred", comment: "")
        }
    }

    var image: UIImage? {
        switch self {
        case .issues:
            return UIImage.issue
        case .repositories:
            return UIImage.repositories
        case .starredRepositories:
            return UIImage.starred
        }
    }
}

protocol WidgetViewDelegate: AnyObject {
    func tapped(widget: HomeWidget)
}

final class WidgetView: UIView {

    func configure(with widget: HomeWidget) {
        self.widget = widget
        titleLabel.text = widget.title
        imageView.image = widget.image
    }

    weak var delegate: WidgetViewDelegate?

    // MARK: - Actions

    @objc func bgButtonTouched() {
        if let widget = self.widget {
            delegate?.tapped(widget: widget)
        }
    }

    // MARK: - Views

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .secondaryLabel
        let image = UIImage(systemName: "chevron.right")
        imageView.image = image
        return imageView
    }()

    private lazy var bgButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(bgButtonTouched), for: .touchUpInside)
        return button
    }()

    private lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .opaqueSeparator
        return view
    }()

    // MARK: - Private variables

    private var widget: HomeWidget?

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
        addSubview(arrowImageView)
        addSubview(bgButton)
        addSubview(separator)

        imageView.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0).isActive = true

        titleLabel.leadingAnchor.constraint(
            equalTo: imageView.trailingAnchor, constant: 4.0).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true

        arrowImageView.widthAnchor.constraint(equalToConstant: 8.0).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
        arrowImageView.trailingAnchor.constraint(
            equalTo: trailingAnchor, constant: -12.0).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true

        bgButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bgButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bgButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bgButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        separator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36.0).isActive = true
        separator.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
    }
}
