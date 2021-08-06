//
//  ProfileDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import UIKit

final class ProfileDIContainer {
    
    struct Dependencies {
        var openUserProfile: (User) -> Void
        var openRepository: (Repository) -> Void
        var sendMail: (String) -> Void
        var openLink: (URL) -> Void
        var share: (URL) -> Void
    }

    let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func createProfileViewController(_ actions: ProfileActions) -> ProfileViewController {
        .create(with: createProfileViewModel(actions))
    }

    func createProfileViewModel(_ actions: ProfileActions) -> ProfileViewModel {
        return ProfileViewModelImpl(useCase: createProfileUseCase(), actions: actions)
    }

    func createProfileUseCase() -> MyProfileUseCase {
        return MyProfileUseCaseImpl(repository: createProfileRepository())
    }

    func createProfileRepository() -> MyProfileRepository {
        return MyProfileRepositoryImpl()
    }

    func createFollowersViewController(actions: ItemsListActions<User>) -> ItemsListViewController<User> {
        .create(with: createFollowersViewModel(actions: actions))
    }

    func createFollowersViewModel(actions: ItemsListActions<User>) -> ItemsListViewModelImpl<User> {
        .init(type: .myFollowers, useCase: createItemsListUseCase(), actions: actions)
    }

    func createFollowingViewController(actions: ItemsListActions<User>) -> ItemsListViewController<User> {
        .create(with: createFollowingViewModel(actions: actions))
    }
    
    func createFollowingViewModel(actions: ItemsListActions<User>) -> ItemsListViewModelImpl<User> {
        .init(type: .myFollowing, useCase: createItemsListUseCase(), actions: actions)
    }

    func createRepositoriesViewController(
        actions: ItemsListActions<Repository>) -> ItemsListViewController<Repository> {
        .create(with: createRepositoriesViewModel(actions: actions))
    }

    func createRepositoriesViewModel(actions: ItemsListActions<Repository>) -> ItemsListViewModelImpl<Repository> {
        .init(type: .myRepositories, useCase: createItemsListUseCase(), actions: actions)
    }

    func createStarredViewController(actions: ItemsListActions<Repository>) -> ItemsListViewController<Repository> {
        .create(with: createStarredViewModel(actions: actions))
    }

    func createStarredViewModel(actions: ItemsListActions<Repository>) -> ItemsListViewModelImpl<Repository> {
        .init(type: .myStarredRepositories, useCase: createItemsListUseCase(), actions: actions)
    }

    func createItemsListUseCase() -> ItemsListUseCase {
        return ItemsListUseCaseImpl.init(repository: createItemsListRepository())
    }

    func createItemsListRepository() -> ItemsListRepository {
        return ItemsListRepositoryImpl()
    }
}
