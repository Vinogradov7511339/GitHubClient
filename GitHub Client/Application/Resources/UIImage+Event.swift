//
//  UIImage+Event.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 01.09.2021.
//

import UIKit

extension UIImage {
    enum Event {
        static var comment: UIImage? { return UIImage(named: "event_comment") }
        static var commit: UIImage? { return UIImage(named: "event_commit") }
        static var fork: UIImage? { return UIImage(named: "event_fork") }
        static var gollum: UIImage? { return UIImage(named: "event_gollum") }
        static var group: UIImage? { return UIImage(named: "event_group") }
        static var issue: UIImage? { return UIImage(named: "event_issue") }
        static var pullRequest: UIImage? { return UIImage(named: "event_pull_request") }
        static var release: UIImage? { return UIImage(named: "event_release") }
        static var repository: UIImage? { return UIImage(named: "event_repository") }
        static var watch: UIImage? { return UIImage(named: "event_watch") }
    }
}
