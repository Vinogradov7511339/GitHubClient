//
//  IntroductionViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 24.08.2021.
//

import UIKit

final class IntroductionViewController: UIViewController {

    // MARK: - Create

    static func create(with scene: IntroScene) -> IntroductionViewController {
        let viewController = IntroductionViewController()
        viewController.scene = scene
        return viewController
    }

    // MARK: - Views

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Private variables

    private var scene: IntroScene!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        descriptionLabel.text = scene.mainTitle
        print("viewDidLoad")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
}

// MARK: - Setup views
private extension IntroductionViewController {
    func setupViews() {
        view.addSubview(descriptionLabel)
    }

    func activateConstraints() {
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
