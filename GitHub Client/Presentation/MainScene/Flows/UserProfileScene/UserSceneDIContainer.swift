//
//  StarredSceneDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class UserSceneDIContainer {

    struct Dependencies {
        let user: User
        var startRepFlow: (Repository) -> Void
        var openLink: (URL) -> Void
        var share: (URL) -> Void
        var sendEmail: (String) -> Void

        let showRecentEvents: (User) -> Void
        let showStarred: (User) -> Void
        let showGists: (User) -> Void
        let showSubscriptions: (User) -> Void
        let showOrganizations: (User) -> Void
        let showEvents: (User) -> Void

        let showRepositories: (User) -> Void
        let showFollowers: (User) -> Void
        let showFollowing: (User) -> Void
    }

    let parentContainer: MainSceneDIContainer
    private let dependencies: Dependencies
    private let userFactory: UserFactory

    init(parentContainer: MainSceneDIContainer, dependencies: Dependencies) {
        self.parentContainer = parentContainer
        self.dependencies = dependencies
        userFactory = UsersListFactoryImpl(dataTransferService: parentContainer.apiDataTransferService)
    }

    // MARK: - Flow Coordinators
    func makeStarredFlowCoordinator(in navigationConroller: UINavigationController) -> UserFlowCoordinator {
        return UserFlowCoordinator(navigationController: navigationConroller, dependencies: self)
    }
}

// MARK: - StarredFlowCoordinatorDependencies
extension UserSceneDIContainer: UserFlowCoordinatorDependencies {
    func profileViewController(actions: UserProfileActions) -> UIViewController {
        userFactory.profileViewController(user: dependencies.user, actions)
    }

    func repositoriesViewController(actions: RepositoriesActions) -> UIViewController {
        userFactory.repositoriesViewController(user: dependencies.user, actions)
    }

    func starredViewController(actions: RepositoriesActions) -> UIViewController {
        userFactory.starredViewController(user: dependencies.user, actions)
    }

    func followersViewController(actions: UsersListActions) -> UIViewController {
        userFactory.followersViewController(user: dependencies.user, actions)
    }

    func followingViewController(actions: UsersListActions) -> UIViewController {
        userFactory.followingViewController(user: dependencies.user, actions)
    }

    func sendMail(email: String) {
        dependencies.sendEmail(email)
    }

    func openLink(url: URL) {
        dependencies.openLink(url)
    }

    func share(url: URL) {
        dependencies.share(url)
    }
}
