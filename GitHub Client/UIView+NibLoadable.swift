//
//  UIView+NibLoadable.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.07.2021.
//

import UIKit

protocol NibLoadable {
    static var nib: UINib { get }
    static var nibName: String { get }
}

extension NibLoadable where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
}
