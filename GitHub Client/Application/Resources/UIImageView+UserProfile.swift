//
//  UIImageView+UserProfile.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

extension UIImage {
    enum UserProfile {
        static var repositories: UIImage? { return UIImage(named: "user_repositories") }
        static var starred: UIImage? { return UIImage(named: "user_starred") }
        static var gists: UIImage? { return UIImage(named: "user_gists") }
        static var events: UIImage? { return UIImage(named: "user_events") }

        static var follow: UIImage? { return UIImage(named: "user_follow") }
        static var unfollow: UIImage? { return UIImage(named: "user_unfollow") }
    }
}
