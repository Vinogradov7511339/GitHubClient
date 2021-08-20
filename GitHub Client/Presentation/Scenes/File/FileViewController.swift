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

    @objc func openMenu() {
        let alert = UIAlertController(title: "Code menu", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Copy File Path", style: .default, handler: { _ in
            self.viewModel.copyFilePath()
        }))
        alert.addAction(UIAlertAction(title: "Share", style: .default, handler: { _ in
            self.viewModel.share()
        }))
        alert.addAction(UIAlertAction(title: "Code Options", style: .default, handler: { _ in
            self.viewModel.openCodeOptions()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
        }))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Binding
extension FileViewController {
    func bind(to viewModel: FileViewModel) {
        viewModel.settings.forceDarkMode.observe(on: self) { [weak self] in self?.changeMode($0) }
        viewModel.settings.lineWrapping.observe(on: self) { [weak self] in self?.changeLineWraping($0) }
        viewModel.settings.showLineNumbers.observe(on: self) { [weak self] in self?.changeLineNumbers($0) }
        viewModel.file.observe(on: self) { [weak self] in self?.update($0) }
    }

    func update(_ file: File?) {
        guard let file = file else { return }
        title = file.name
//        navigationItem.prompt = file.path
        label.text = file.content
    }

    func changeMode(_ darkMode: Bool) {
        overrideUserInterfaceStyle = darkMode ? .dark : .light
    }

    func changeLineWraping(_ lineWrapping: Bool) {
        label.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -16.0).isActive = lineWrapping
    }

    func changeLineNumbers(_ showLineNubers: Bool) {}
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
