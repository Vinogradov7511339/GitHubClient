//
//  UIImage+Repository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.08.2021.
//

import UIKit

extension UIImage {
    enum Repository {

        // MARK: - Sources

        static var folderBlue: UIImage? { UIImage(named: "rep_item_folder_blue") }
        static var file: UIImage? { UIImage(named: "rep_item_file") }

        // MARK: - Badges

        static var star: UIImage? { UIImage(named: "rep_item_star") }
        static var fork: UIImage? { UIImage(named: "repository_fork") }

        // MARK: - Items

        static var branch: UIImage? { UIImage(named: "rep_item_branch") }
        static var sources: UIImage? { UIImage(named: "rep_item_sources") }
        static var issues: UIImage? { UIImage(named: "rep_item_issues") }
        static var pullRequests: UIImage? { UIImage(named: "rep_item_pull_requests") }
        static var releases: UIImage? { UIImage(named: "rep_item_releases") }
        static var watchers: UIImage? { UIImage(named: "repositry_watchers") }
        static var commits: UIImage? { UIImage(named: "rep_item_commits") }
        static var license: UIImage? { UIImage(named: "repository_license") }
    }
}
