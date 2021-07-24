//
//  ApplicationPresenter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

class ApplicationPresenter {
    
    static let shared = ApplicationPresenter()
    
    var window: UIWindow!
    
    var languageColorsDict: [String: String] = [:]
    
    private init() {
        setupObservers()
        setupLanguageColors()
    }
    
    func logout() {
        UserStorage.shared.clearStorage()
        URLCache.shared.removeAllCachedResponses()
        let loginController = LoginViewController()
        let previousController = window.rootViewController
        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft) {
            self.window.subviews.forEach { $0.removeFromSuperview() }
            self.window.rootViewController = loginController
        } completion: { _ in
            previousController?.dismiss(animated: false, completion: {
                previousController?.view.removeFromSuperview()
            })
        }
    }
    
    func login() {
        let tabbarController = TabBarController()
        let previousController = window.rootViewController
        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft) {
            self.window.subviews.forEach { $0.removeFromSuperview() }
            self.window.rootViewController = tabbarController
        } completion: { _ in
            previousController?.dismiss(animated: false, completion: {
                previousController?.view.removeFromSuperview()
            })
        }
    }
    
    private func setupObservers() {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(didReceiveCriticalError(notification:)), name: Notification.Name.NetworkService.CriticalError, object: nil)
    }
    
    @objc func didReceiveCriticalError(notification: Notification) {
        guard let error = notification.userInfo?["errorInfo"] as? ErrorResponse else {
            return
        }
        assert(false, "error: \(error)")
    }
    
    private func setupLanguageColors() {
        guard let path = Bundle.main.path(forResource: "LanguageColors", ofType: "json") else {
            assert(false, "Can not find file LanguageColors.json")
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let languageColorsDict = jsonResult as? Dictionary<String, String> {
                self.languageColorsDict = languageColorsDict
            }
        } catch {
            assert(false, "Error \(error)")
        }
    }
}
