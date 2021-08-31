//
//  StarredSceneDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class UserProfileDIContainer {

    // MARK: - Dependencies

    struct Dependencies {
        let dataTransferService: DataTransferService
        let userUrl: URL

        var startRepFlow: (URL, UINavigationController) -> Void
        var openLink: (URL) -> Void
        var share: (URL) -> Void
        var sendEmail: (String) -> Void
    }

    // MARK: - Private variables

    private let dependencies: Dependencies
    private let userFactory: UserFactory

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        userFactory = UsersListFactoryImpl(dataTransferService: dependencies.dataTransferService)
    }
}

// MARK: - StarredFlowCoordinatorDependencies
extension UserProfileDIContainer: UserFlowCoordinatorDependencies {
    func sendMail(email: String) {
        dependencies.sendEmail(email)
    }

    func openLink(url: URL) {
        dependencies.openLink(url)
    }

    func share(url: URL) {
        dependencies.share(url)
    }

    // MARK: - Factory

    func profileViewController(actions: UserProfileActions) -> UIViewController {
        userFactory.profileViewController(userUrl: dependencies.userUrl, actions)
    }

    func repositoriesViewController(actions: RepositoriesActions) -> UIViewController {
        fatalError()
//        userFactory.repositoriesViewController(user: dependencies.user, actions)
    }

    func starredViewController(actions: RepositoriesActions) -> UIViewController {
        fatalError()
//        userFactory.starredViewController(user: dependencies.user, actions)
    }

    func followersViewController(actions: UsersActions) -> UIViewController {
        fatalError()
//        userFactory.followersViewController(user: dependencies.user, actions)
    }

    func followingViewController(actions: UsersActions) -> UIViewController {
        fatalError()
//        userFactory.followingViewController(user: dependencies.user, actions)
    }
}
