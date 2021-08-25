//
//  IntroductionViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 24.08.2021.
//

import UIKit
import Lottie

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
        label.textAlignment = .center
        return label
    }()

    private lazy var animationView: AnimationView = {
        let view = AnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.animation = Animation.named(scene.animationName)
        view.backgroundBehavior = .pauseAndRestore
        view.loopMode = .loop
        return view
    }()

    // MARK: - Private variables

    private var scene: IntroScene!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        descriptionLabel.text = scene.mainTitle
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animationView.play()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        animationView.stop()
    }
}

// MARK: - Setup views
private extension IntroductionViewController {
    func setupViews() {
        view.addSubview(descriptionLabel)
        view.addSubview(animationView)
    }

    func activateConstraints() {
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: 80.0).isActive = true

        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 16.0).isActive = true
    }
}
