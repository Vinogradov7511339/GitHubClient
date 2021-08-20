//
//  UIImage+Repository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.08.2021.
//

import UIKit

extension UIImage {
    static var folder: UIImage? { UIImage(named: "rep_item_folder") }
    static var file: UIImage? { UIImage(named: "rep_item_file") }
    static var sources: UIImage? { UIImage(named: "rep_item_sources") }
    static var star: UIImage? { UIImage(named: "rep_item_star") }
    static var fork: UIImage? { UIImage(named: "rep_item_fork") }
}
