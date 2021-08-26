//
//  UIViewController+Error.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 26.08.2021.
//

import UIKit

extension UIViewController {

    func showError(_ error: Error, reloadCompletion: @escaping () -> Void) {
        let alert = ErrorAlertView.create(with: error, reloadHandler: reloadCompletion)
        alert.show(in: view)
    }

    func hideError() {
        view.subviews
            .filter { $0 is ErrorAlertView }
            .forEach { $0.removeFromSuperview() }
    }
}
