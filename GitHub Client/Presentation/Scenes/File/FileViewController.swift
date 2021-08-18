//
//  FileViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

class FileViewController: UIViewController {

    static func create(with viewModel: FileViewModel) -> FileViewController {
        let viewController = FileViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    private var viewModel: FileViewModel!
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        activateConstraints()

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

// MARK: - Binding
extension FileViewController {
    func bind(to viewModel: FileViewModel) {
        viewModel.content.observe(on: self) { [weak self] in self?.update($0) }
    }

    func update(_ content: String) {
        label.text = content
    }
}

// MARK: - setup views
private extension FileViewController {
    func setupViews() {
        view.addSubview(label)
    }

    func activateConstraints() {
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
