//
//  UIImage+TabBar.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import UIKit

extension UIImage {
    enum TabBar {
        static var home: UIImage? { UIImage(named: "tab_item_home") }
        static var explore: UIImage? { UIImage(named: "tab_item_explore") }
        static var notifications: UIImage? { UIImage(named: "tab_item_notification_empty") }
        static var profile: UIImage? { UIImage(named: "tab_item_profile") }
        static var signIn: UIImage? { UIImage(named: "tab_item_sign_in") }
    }
}
