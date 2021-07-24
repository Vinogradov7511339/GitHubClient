//
//  UIImage+extensions.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

extension UIImage {
    static var issue: UIImage? {
        return UIImage(systemName: "smallcircle.fill.circle")
    }
    
    static var pullRequest: UIImage? {
        return UIImage(named: "icon_cell_git_pull_request")
    }
    
    static var releases: UIImage? {
        return UIImage(systemName: "tag")
    }
    
    static var discussions: UIImage? {
        return UIImage(systemName: "message")
    }
    
    static var watchers: UIImage? {
        return UIImage(named: "icon_cell_theme")
    }
    
    static var license: UIImage? {
        return UIImage(systemName: "scalemass")
    }
}
