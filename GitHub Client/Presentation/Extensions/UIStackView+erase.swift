//
//  UIStackView+erase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.09.2021.
//

import UIKit

extension UIStackView {
    func erase() {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
