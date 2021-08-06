//
//  StarredFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

protocol UserFlowCoordinatorDependencies {
    func makeUserProfileViewController(actions: UserProfileActions) -> UserProfileViewController
    func makeStarredViewController(actions: ItemsListActions<Repository>) -> ItemsListViewController<Repository>
    func startRepFlow(_ repository: Repository)
    func sendMail(email: String)
    func openLink(url: URL)
    func share(url: URL)
}

final class UserFlowCoordinator {

    private weak var navigationController: UINavigationController?
    private let dependencies: UserFlowCoordinatorDependencies

    init(navigationController: UINavigationController, dependencies: UserFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let actions = actions()
        let viewController = dependencies.makeUserProfileViewController(actions: actions)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension UserFlowCoordinator {
    func actions() -> UserProfileActions {
        .init(showFollowers: showFollowers(_:),
              showFollowing: showFollowing(_:),
              showRepository: dependencies.startRepFlow(_:),
              showRepositories: showRepositories(_:),
              showStarred: showStarred(_:),
              showOrganizations: showOrganizations(_:),
              sendEmail: dependencies.sendMail(email:),
              openLink: dependencies.openLink(url:),
              share: dependencies.share(url:)
        )
    }
    
    func showFollowers(_ user: User) {}
    func showFollowing(_ user: User) {}
    func showRepositories(_ user: User) {}

    func showStarred(_ user: User) {
        let actions = ItemsListActions(showDetails: dependencies.startRepFlow(_:))
        let viewController = dependencies.makeStarredViewController(actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showOrganizations(_ user: User) {}
}
