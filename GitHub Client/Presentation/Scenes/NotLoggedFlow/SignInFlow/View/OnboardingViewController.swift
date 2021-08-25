//
//  OnboardingViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 24.08.2021.
//

import UIKit

final class OnboardingViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: LoginViewModel) -> OnboardingViewController {
        let viewController = OnboardingViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var authButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(authButtonTapped), for: .touchUpInside)
        button.setTitle("Auth with Github", for: .normal)
        button.setTitleColor(.link, for: .normal)
        return button
    }()

    private lazy var pageController: OnboardingPageController = {
        let controller = OnboardingPageController.create(with: childControllers)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }()

    private lazy var authorizationViewController: UIViewController = {
        let viewController = AuthorizationViewController()
        viewController.delegate = self

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .overFullScreen
        return navigationController
    }()

    private lazy var childControllers: [UIViewController] = {
        viewModel.introScenes.map { IntroductionViewController.create(with: $0) }
    }()

    // MARK: - Private variables

    private var viewModel: LoginViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        configureNavBar()
        viewModel.viewDidLoad()
    }
}

// MARK: - Actions
extension OnboardingViewController {
    @objc func authButtonTapped() {
        present(authorizationViewController, animated: true, completion: nil)
    }

    @objc func openSettings() {
        viewModel.openSettings()
    }
}

// MARK: - AuthorizationViewControllerDelegate
extension OnboardingViewController: AuthorizationViewControllerDelegate {
    func fetchToken(authCode: String) {
        viewModel.fetchToken(authCode: authCode)
    }

    func failure() {
        // todo
    }
}

// MARK: - Setup views
private extension OnboardingViewController {
    func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(container)
        view.addSubview(authButton)

        addChild(pageController)
        container.addSubview(pageController.view)
    }

    func activateConstraints() {
        container.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: authButton.topAnchor, constant: -32.0).isActive = true

        authButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        authButton.widthAnchor.constraint(equalToConstant: 160.0).isActive = true
        authButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        authButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16.0).isActive = true

        pageController.view.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        pageController.view.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        pageController.view.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        pageController.view.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
    }

    func configureNavBar() {
        let settings = UIBarButtonItem(image: .settings,
                                       style: .plain,
                                       target: self,
                                       action: #selector(openSettings))
        navigationItem.setRightBarButton(settings, animated: false)
    }
}
