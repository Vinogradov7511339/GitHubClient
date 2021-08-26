//
//  UIView+IBInspectable.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 24.07.2021.
//

import UIKit

extension UIView {

    @IBInspectable var borderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    @IBInspectable var borderColor: UIColor? {
        get { layer.borderColor?.uiColor }
        set { layer.borderColor = newValue?.cgColor }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }

    @IBInspectable var shadowOffset: CGSize {
        get { layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }

    @IBInspectable var shadowOpacity: Float {
        get { layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }

    @IBInspectable var shadowRadius: CGFloat {
        get { layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }

    @IBInspectable var shadowColor: UIColor? {
        get { layer.shadowColor?.uiColor }
        set { layer.shadowColor = newValue?.cgColor }
    }

    @IBInspectable var innerClipsToBounds: Bool {
        get { return clipsToBounds }
        set { clipsToBounds = newValue }
    }
}

extension CGColor {
    var uiColor: UIKit.UIColor {
        return UIColor(cgColor: self)
    }
}
