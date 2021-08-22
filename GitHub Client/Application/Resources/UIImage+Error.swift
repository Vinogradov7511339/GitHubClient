//
//  UIImage+Error.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

extension UIImage {
    enum Error {
        static var notFound: UIImage? { UIImage(named: "error_not_found") }
    }
}
