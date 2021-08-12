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

    init(parentContainer: MainSceneDIContainer, dependencies: Dependencies) {
        self.parentContainer = parentContainer
        self.dependencies = dependencies
    }

    // MARK: - Flow Coordinators
    func makeStarredFlowCoordinator(in navigationConroller: UINavigationController) -> UserFlowCoordinator {
        return UserFlowCoordinator(navigationController: navigationConroller, dependencies: self)
    }
}

// MARK: - StarredFlowCoordinatorDependencies
extension UserSceneDIContainer: UserFlowCoordinatorDependencies {
    func showFollowers(_ user: User) {
        dependencies.showFollowers(user)
    }

    func showFollowing(_ user: User) {
        dependencies.showFollowing(user)
    }

    func showRepositories(_ user: User) {
        dependencies.showRepositories(user)
    }

    func showRecentEvents(_ user: User) {
        dependencies.showRecentEvents(user)
    }

    func showGists(_ user: User) {
        dependencies.showGists(user)
    }

    func showSubscriptions(_ user: User) {
        dependencies.showSubscriptions(user)
    }

    func showEvents(_ user: User) {
        dependencies.showEvents(user)
    }

    func showOrganizations(_ user: User) {
        dependencies.showOrganizations(user)
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
        return UserProfileUseCaseImpl(repository: makeUserRepository())
    }

    func makeUserRepository() -> UserProfileRepository {
        return UserProfileRepositoryImpl(
            dataTransferService: parentContainer.apiDataTransferService)
    }

    // MARK: - Starred flow

    func makeStarredViewController(actions: ItemsListActions<Repository>) -> ItemsListViewController<Repository> {
        return ItemsListViewController.create(with: makeStarredViewModel(actions: actions))
    }

    func makeStarredViewModel(actions: ItemsListActions<Repository>) -> ItemsListViewModelImpl<Repository> {
        return ItemsListViewModelImpl(
            type: .userStarredRepositories(dependencies.user),
            useCase: makeStarredUseCase(),
            actions: actions)
    }

    func makeStarredUseCase() -> ItemsListUseCase {
        return ItemsListUseCaseImpl(repository: makeStarredRepository())
    }

    func makeStarredRepository() -> ItemsListRepository {
        return ItemsListRepositoryImpl(
            dataTransferService: parentContainer.apiDataTransferService)
    }
}
