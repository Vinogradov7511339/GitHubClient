//
//  UIViewController+ActivityIndicator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.09.2021.
//

import UIKit

extension UIViewController {

    func makeActivityIndicator(size: CGSize) -> UIActivityIndicatorView {
        let style: UIActivityIndicatorView.Style = .medium
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        activityIndicator.frame = .init(origin: .zero, size: size)
        return activityIndicator
    }
}
