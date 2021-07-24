//
//  LoginViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.07.2021.
//

import UIKit
import WebKit

class LoginViewController: UIViewController {
    
    //todo dark theme
    private lazy var gitHubImageView: UIImageView = {
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = imageView.frame.height / 2.0
        return imageView
    }()
    
    // todo font, localize text, dynamic corners
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signInButtonTouchUpInside), for: .touchUpInside)
        button.setTitle("Sign with GitHub", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 40.0
        return button
    }()
    
    // todo font, localize text, links
    private lazy var licenseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "By signing in you accept our Term of use and Privacy policy."
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var authorizationViewController: UIViewController = {
        let viewController = AuthorizationViewController()
        viewController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .overFullScreen
        return navigationController
    }()
    
    private let webView = WKWebView()
    private let service = ServicesManager.shared.tokenService
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareScreen()
    }
    
    @objc func signInButtonTouchUpInside() {
        present(authorizationViewController, animated: true, completion: nil)
    }
    
    private func prepareScreen() {
        setupViews()
        activateConstraints()
        view.backgroundColor = UIColor.black
    }
}

extension LoginViewController: AuthorizationViewControllerDelegate {
    func success(tokenResponse: TokenResponse) {
        UserStorage.shared.saveTokenResponse(tokenResponse)
        ApplicationPresenter.shared.login()
    }
    
    func failure() {
        //todo
    }
}

// MARK: - setup views
private extension LoginViewController {
    func setupViews() {
        view.addSubview(gitHubImageView)
        view.addSubview(signInButton)
        view.addSubview(licenseLabel)
    }
    
    // todo change
    func activateConstraints() {
        gitHubImageView.widthAnchor.constraint(equalToConstant: gitHubImageView.intrinsicContentSize.width).isActive = true
        gitHubImageView.heightAnchor.constraint(equalTo: gitHubImageView.widthAnchor).isActive = true
        gitHubImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gitHubImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 46.0).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -46.0).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        signInButton.bottomAnchor.constraint(equalTo: licenseLabel.topAnchor, constant: -14.0).isActive = true
        
        licenseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 62.0).isActive = true
        licenseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -62.0).isActive = true
        licenseLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60.0).isActive = true
    }
}
