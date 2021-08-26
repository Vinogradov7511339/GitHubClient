//
//  UIViewController+Loading.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 26.08.2021.
//

import UIKit

extension UIViewController {

    func showLoader() {
        guard !isExist else { return }
        setupLoader()
    }

    func hideLoader() {
        view.subviews
            .filter { $0 is UIActivityIndicatorView }
            .forEach { $0.removeFromSuperview() }
    }

    private var isExist: Bool {
        !view.subviews
            .filter { $0 is UIActivityIndicatorView }
            .isEmpty
    }

    private func setupLoader() {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loader.startAnimating()
    }
}
