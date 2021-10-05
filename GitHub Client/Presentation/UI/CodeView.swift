//
//  CodeView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 29.08.2021.
//

import UIKit

final class CodeView: UIView {

    // MARK: - Views

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
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
        setupViews()
        activateConstraints()
        observe()
    }
}

// MARK: - Setup views
private extension CodeView {
    func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(label)
    }

    func activateConstraints() {
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}

// MARK: - Settings observing
private extension CodeView {
    func observe() {
        let codeOptions = SettingsStorageImpl.shared.codeOptions
        codeOptions.lineWrapping.observe(on: self) { [weak self] in self?.lineWrapping($0) }
        codeOptions.forceDarkMode.observe(on: self) { [weak self] in self?.forceDarkMode($0) }
        codeOptions.showLineNumbers.observe(on: self) { [weak self] in self?.lineNumbers($0) }
    }

    func forceDarkMode(_ forceDarkMode: Bool) {
        overrideUserInterfaceStyle = forceDarkMode ? .dark : .light
    }

    func lineWrapping(_ bool: Bool) {

    }

    func lineNumbers(_ bool: Bool) {

    }
}
