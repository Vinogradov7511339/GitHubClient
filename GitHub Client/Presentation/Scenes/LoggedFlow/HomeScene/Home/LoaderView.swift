//
//  LoaderView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.09.2021.
//

import UIKit

final class LoaderView: UIView {

    func show(_ title: String) {
        isHidden = false
        titleLabel.text = title
        activityIndicator.startAnimating()
    }

    func hide() {
        activityIndicator.stopAnimating()
        isHidden = true
    }

    // MARK: - Views

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        competeInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        competeInit()
    }

    private func competeInit() {
        addSubview(activityIndicator)
        addSubview(titleLabel)

        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 24.0).isActive = true

        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(
            equalTo: activityIndicator.bottomAnchor, constant: 24.0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24.0).isActive = true
    }
}
