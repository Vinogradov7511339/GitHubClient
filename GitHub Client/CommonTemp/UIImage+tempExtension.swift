//
//  UIImage+tempExtension.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import UIKit

extension UIImage {
     static var issue: UIImage? {
        UIImage(systemName: "smallcircle.fill.circle")
     }

     static var pullRequest: UIImage? {
        UIImage(named: "icon_cell_git_pull_request")
     }

     static var releases: UIImage? {
        UIImage(systemName: "tag")
     }

     static var discussions: UIImage? {
        UIImage(systemName: "message")
     }

     static var watchers: UIImage? {
        UIImage(named: "icon_cell_theme")
     }

     static var license: UIImage? {
        UIImage(systemName: "scalemass")
     }
 }

extension UIColor {
    static var issue: UIColor { .systemGreen }
    static var pullRequest: UIColor { .systemBlue }
    static var discussions: UIColor { .systemPurple }
    static var repositories: UIColor { .systemGray }
    static var organizations: UIColor { .systemOrange }

    static var releases: UIColor { .systemGray }
    static var watchers: UIColor { .systemYellow }
    static var license: UIColor { .systemRed }
}

extension String {
    static var issue: String {
        NSLocalizedString("Issues", comment: "")
    }

    static var pullRequest: String {
        NSLocalizedString("Pull Requests", comment: "")
    }

    static var discussions: String {
        NSLocalizedString("Discussions", comment: "")
    }

    static var repositories: String {
        NSLocalizedString("Repositories", comment: "")
    }

    static var organizations: String {
        NSLocalizedString("Organizations", comment: "")
    }

    static var releases: String {
        NSLocalizedString("Releases", comment: "")
    }

    static var watchers: String {
        NSLocalizedString("Watchers", comment: "")
    }

    static var license: String {
        NSLocalizedString("License", comment: "")
    }
}
