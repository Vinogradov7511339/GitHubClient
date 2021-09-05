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

        static var folderBlue: UIImage? { UIImage(named: "icon_cell_source") }
        static var file: UIImage? { UIImage(systemName: "doc") }

        // MARK: - Info items

        static var license: UIImage? { UIImage(named: "repository_license") }

        // MARK: - Popular section

        static var forks: UIImage? { UIImage(named: "repository_forks") }
        static var subscribers: UIImage? { UIImage(named: "repository_subscribers") }
        static var contributors: UIImage? { UIImage(named: "repository_contributors") }
        static var stargazers: UIImage? { UIImage(named: "repository_stargazers") }

        // MARK: - Activity section

        static var branch: UIImage? { UIImage(named: "rep_item_branch") }
        static var sources: UIImage? { UIImage(named: "rep_item_sources") }
        static var issues: UIImage? { UIImage(named: "rep_item_issues") }
        static var pullRequests: UIImage? { UIImage(named: "rep_item_pull_requests") }
        static var releases: UIImage? { UIImage(named: "rep_item_releases") }
        static var commits: UIImage? { UIImage(named: "rep_item_commits") }
    }
}
