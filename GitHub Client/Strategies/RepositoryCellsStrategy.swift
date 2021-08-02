//
//  RepositoryCellsStrategy.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

class RepositoryCellsStrategy {

    private let repositoryInfo: RepositoryInfo

    init(repositoryInfo: RepositoryInfo) {
        self.repositoryInfo = repositoryInfo
    }

    func viewModels() -> [Any] {
        var viewModels = defaultViewModels()

        if repositoryInfo.releasesCount != 0 {
            let releases = TableCellViewModel(
                text: "Releases",
                detailText: "\(repositoryInfo.releasesCount)",
                image: UIImage.releases,
                imageTintColor: .systemGray,
                accessoryType: .disclosureIndicator)
            viewModels.insert(releases, at: 2)
        }

        if repositoryInfo.discussionsCount != 0 {
            let discussions = TableCellViewModel(
                text: "Discussions",
                detailText: "\(repositoryInfo.discussionsCount)",
                image: UIImage.discussions,
                imageTintColor: .systemPurple,
                accessoryType: .disclosureIndicator)
            viewModels.insert(discussions, at: 3)
        }

        return viewModels
    }

    private func defaultViewModels() -> [Any] {
        var viewModels: [Any] = []
        let issuesViewModel = TableCellViewModel(
            text: "Issues",
            detailText: "\(repositoryInfo.repository.openIssuesCount ?? 0)",
            image: UIImage.issue,
            imageTintColor: .systemGreen,
            accessoryType: .disclosureIndicator)
        viewModels.append(issuesViewModel)

        let pullRequests = TableCellViewModel(
            text: "Pull Requests", detailText: "\(repositoryInfo.pullRequestsCount)",
            image: UIImage.pullRequest,
            imageTintColor: .systemBlue,
            accessoryType: .disclosureIndicator)
        viewModels.append(pullRequests)

        let watchers = TableCellViewModel(
            text: "Watchers",
            detailText: "\(repositoryInfo.repository.watchersCount ?? 0)",
            image: UIImage.watchers,
            imageTintColor: .systemYellow,
            accessoryType: .disclosureIndicator)
        viewModels.append(watchers)

        let license = TableCellViewModel(
            text: "License",
            detailText: "\(repositoryInfo.repository.license?.name ?? "NaN")",
            image: UIImage.license,
            imageTintColor: .systemRed,
            accessoryType: .disclosureIndicator)
        viewModels.append(license)

        return viewModels
    }
}
