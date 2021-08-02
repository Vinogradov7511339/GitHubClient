//
//  FileViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

class FileViewController: UIViewController {
    var presenter: FilePresenterInput!
    
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
        presenter.viewDidLoad()
    }
}

// MARK: - FilePresenterOutput
extension FileViewController: FilePresenterOutput {
    func display(text: String) {
        label.text = text
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
