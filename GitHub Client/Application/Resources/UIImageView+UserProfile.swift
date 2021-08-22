//
//  UIImageView+UserProfile.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

extension UIImage {
    enum UserProfile {
        static var follow: UIImage? { UIImage(named: "user_profile_follow") }
        static var following: UIImage? { UIImage(named: "user_profile_folloing") }
        static var followers: UIImage? { UIImage(named: "user_profile_followers") }
        static var repositories: UIImage? { UIImage(named: "user_profile_repositories") }
        static var info: UIImage? { UIImage(named: "user_profile_info") }
    }
}
