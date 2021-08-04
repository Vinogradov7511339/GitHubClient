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
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Flow Coordinators
    func makeStarredFlowCoordinator(navigationConroller: UINavigationController) -> UserFlowCoordinator {
        return UserFlowCoordinator(navigationController: navigationConroller, dependencies: self)
    }
}

// MARK: - StarredFlowCoordinatorDependencies
extension UserSceneDIContainer: UserFlowCoordinatorDependencies {
    func sendMail(email: String) {
        dependencies.sendEmail(email)
    }

    func openLink(url: URL) {
        dependencies.openLink(url)
    }

    func share(url: URL) {
        dependencies.share(url)
    }

    func startRepFlow(_ repository: Repository) {
        dependencies.startRepFlow(repository)
    }

    // MARK: - UserProfile flow

    func makeUserProfileViewController(actions: UserProfileActions) -> UserProfileViewController {
        return UserProfileViewController.create(with: makeUserProfileViewModel(actions: actions))
    }

    func makeUserProfileViewModel(actions: UserProfileActions) -> UserProfileViewModel {
        return UserProfileViewModelImpl(user: dependencies.user,
                                        userProfileUseCase: makeUserProfileUseCase(),
                                        actions: actions)
    }

    func makeUserProfileUseCase() -> UserProfileUseCase {
        return UserProfileUseCaseImpl()
    }

    // MARK: - Starred flow

    func makeStarredViewController(actions: StarredActions) -> StarredViewController {
        return StarredViewController.create(
            with: makeStarredViewModel(actions: actions))
    }

    func makeStarredViewModel(actions: StarredActions) -> StarredViewModel {
        return StarredViewModelImpl(starredUseCase: makeStarredUseCase(), actions: actions)
    }

    func makeStarredUseCase() -> StarredUseCase {
        return StarredUseCaseImpl(user: dependencies.user, repository: makeStarredRepository())
    }

    func makeStarredRepository() -> StarredRepository {
        return StarredRepositoryImpl()
    }
}
