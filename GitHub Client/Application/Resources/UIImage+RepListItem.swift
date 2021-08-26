//
//  UIImage+RepListItem.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.08.2021.
//

import UIKit

extension UIImage {
    enum RepListItem {
        static var stars: UIImage? { UIImage(named: "rep_list_item_star") }
        static var forks: UIImage? { UIImage(named: "rep_list_item_fork") }
        static var issues: UIImage? { UIImage(named: "rep_list_item_issue") }
        static var watchers: UIImage? { UIImage(named: "rep_list_item_watcher") }

        static var star: UIImage? { UIImage(named: "rep_list_star") }
        static var fork: UIImage? { UIImage(named: "rep_list_fork") }
    }
}
