//
//  AuthorizationViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit
import WebKit

protocol AuthorizationViewControllerDelegate: AnyObject {
    func fetchToken(authCode: String)
    func failure()
}

class AuthorizationViewController: UIViewController {
    private lazy var webView: WKWebView = {
        let webview = WKWebView()
        webview.translatesAutoresizingMaskIntoConstraints = false
        webview.navigationDelegate = self
        return webview
    }()
    
    private lazy var authRequest: URLRequest = {
        let stringUrl = "https://github.com/login/oauth/authorize?client_id=" + GithubConstants.clientId + "&scope=" + GithubConstants.permissionsScope + "&redirect_uri=" + GithubConstants.redirectUrl + "&state=" + uuid
        let url = URL(string: stringUrl)!
        let request = URLRequest(url: url)
        return request
    }()
    
    weak var delegate: AuthorizationViewControllerDelegate?

    private let uuid = UIDevice.current.identifierForVendor!.uuidString

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        configureNavigationBar()

        webView.load(authRequest)
    }

    @objc func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func refreshAction() {
        self.webView.reload()
    }

    private func configureNavigationBar() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                           target: self,
                                           action: #selector(self.cancelAction))
        navigationItem.leftBarButtonItem = cancelButton

        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh,
                                            target: self,
                                            action: #selector(self.refreshAction))
        navigationItem.rightBarButtonItem = refreshButton
    }

    private func requestForCallbackUl(_ request: URLRequest) {
        let stringUrl = request.url?.absoluteString ?? ""
        guard let components = URLComponents(string: stringUrl) else {
            print("no components")
            return
        }
        guard let parameter = components.queryItems?.first(where: { $0.name == "code" }) else {
            print("no code")
            return
        }
        guard let code = parameter.value else {
            print("no code")
            return
        }
        delegate?.fetchToken(authCode: code)
    }
}

// MARK: - WKNavigationDelegate
extension AuthorizationViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        self.requestForCallbackUl(navigationAction.request)
        decisionHandler(.allow)
    }
}

// MARK: - setup views
private extension AuthorizationViewController {
    func setupViews() {
        view.addSubview(webView)
    }

    func activateConstraints() {
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
