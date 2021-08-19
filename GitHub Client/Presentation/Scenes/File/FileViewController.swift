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

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        view.backgroundColor = .systemBackground
        configureNavBar()

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    @objc func openCodeSettings() {
        let viewController = CodeOptionsViewController()
        let nav = UINavigationController(rootViewController: viewController)
        present(nav, animated: true, completion: nil)
    }

    @objc func openMenu() {}
}

// MARK: - Binding
extension FileViewController {
    func bind(to viewModel: FileViewModel) {
        viewModel.file.observe(on: self) { [weak self] in self?.update($0) }
    }

    func update(_ file: File?) {
        guard let file = file else { return }
        title = file.name
//        navigationItem.prompt = file.path
        label.text = file.content
    }
}

// MARK: - setup views
private extension FileViewController {
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(label)
    }

    func activateConstraints() {
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }

    func configureNavBar() {
        let menuButton = UIBarButtonItem(image: .menu,
                                         style: .plain,
                                         target: self,
                                         action: #selector(openMenu))
        navigationItem.setRightBarButton(menuButton, animated: true)
    }
}
