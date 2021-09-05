//
//  DiffHeaderView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.09.2021.
//

import UIKit

protocol DiffHeaderViewDelegate: AnyObject {
    func expandButtonTapped()
}

final class DiffHeaderView: UIView {

    weak var delegate: DiffHeaderViewDelegate?

    func configure(fileName: String, isExpanded: Bool) {
        fileNameLabel.text = fileName
        self.isExpanded = isExpanded
    }

    private lazy var exploreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(expandButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var fileNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14.0)
        label.lineBreakMode = .byTruncatingHead
        return label
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .opaqueSeparator
        return view
    }()

    private var isExpanded = false {
        didSet {
            let imageName = isExpanded ? "chevron.down" : "chevron.right"
            exploreButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }

    @objc func expandButtonTapped() {
        delegate?.expandButtonTapped()
        isExpanded = !isExpanded
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        completeInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        completeInit()
    }

    private func completeInit() {
        addSubview(exploreButton)
        addSubview(fileNameLabel)
        addSubview(separatorView)

        exploreButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0).isActive = true
        exploreButton.topAnchor.constraint(equalTo: topAnchor, constant: 12.0).isActive = true
        exploreButton.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        exploreButton.heightAnchor.constraint(equalToConstant: 24.0).isActive = true

        fileNameLabel.leadingAnchor.constraint(
            equalTo: exploreButton.trailingAnchor, constant: 12.0).isActive = true

        fileNameLabel.centerYAnchor.constraint(
            equalTo: exploreButton.centerYAnchor).isActive = true

        fileNameLabel.trailingAnchor.constraint(
            equalTo: trailingAnchor, constant: -12.0).isActive = true

        separatorView.topAnchor.constraint(
            equalTo: exploreButton.bottomAnchor, constant: 4.0).isActive = true

        separatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4.0).isActive = true
    }
}
