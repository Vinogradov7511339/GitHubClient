//
//  RepositoryFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import UIKit

protocol RepositoryFactory {
    func repositoryViewController() -> UIViewController
    func branchesViewController() -> UIViewController
    func commitsViewController() -> UIViewController
    func commitViewController() -> UIViewController
    func folderViewController() -> UIViewController
    func fileViewController() -> UIViewController
    func issuesViewController() -> UIViewController
    func issueViewController() -> UIViewController
    func pullRequestsViewController() -> UIViewController
    func pullRequestViewController() -> UIViewController
    func releasesViewController() -> UIViewController
    func releaseViewController() -> UIViewController
    func licenseViewController() -> UIViewController
    func watchersViewController() -> UIViewController
    func forksViewController() -> UIViewController
}

final class RepositoryFactoryImpl {}

// MARK: - RepositoryFactory
extension RepositoryFactoryImpl: RepositoryFactory {
    func repositoryViewController() -> UIViewController {
        UIViewController()
    }

    func branchesViewController() -> UIViewController {
        UIViewController()
    }

    func commitsViewController() -> UIViewController {
        UIViewController()
    }

    func commitViewController() -> UIViewController {
        UIViewController()
    }

    func folderViewController() -> UIViewController {
        UIViewController()
    }

    func fileViewController() -> UIViewController {
        UIViewController()
    }

    func issuesViewController() -> UIViewController {
        UIViewController()
    }

    func issueViewController() -> UIViewController {
        UIViewController()
    }

    func pullRequestsViewController() -> UIViewController {
        UIViewController()
    }

    func pullRequestViewController() -> UIViewController {
        UIViewController()
    }

    func releasesViewController() -> UIViewController {
        UIViewController()
    }

    func releaseViewController() -> UIViewController {
        UIViewController()
    }

    func licenseViewController() -> UIViewController {
        UIViewController()
    }

    func watchersViewController() -> UIViewController {
        UIViewController()
    }

    func forksViewController() -> UIViewController {
        UIViewController()
    }
}

// MARK: - Private
private extension RepositoryFactoryImpl {

}
