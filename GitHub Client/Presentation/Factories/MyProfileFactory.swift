//
//  MyProfileFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import UIKit

protocol MyProfileFactory {
    func profileViewController(actions: ProfileActions) -> UIViewController
    func followersViewController(_ url: URL, actions: UsersActions) -> UIViewController
    func followingViewController(_ url: URL, actions: UsersActions) -> UIViewController
    func repositoriesViewController(_ url: URL, actions: RepositoriesActions) -> UIViewController
    func starredViewController(_ url: URL, actions: RepositoriesActions) -> UIViewController
    func subscriptionsViewControler() -> UIViewController
}

final class MyProfileFactoryImpl {

    private let dataTransferService: DataTransferService
    private let storage: ProfileLocalStorage

    init(dataTransferService: DataTransferService, storage: ProfileLocalStorage) {
        self.dataTransferService = dataTransferService
        self.storage = storage
    }
}

// MARK: - MyProfileFactory
extension MyProfileFactoryImpl: MyProfileFactory {
    func profileViewController(actions: ProfileActions) -> UIViewController {
        ProfileViewController.create(with: profileViewModel(actions))
    }

    func followersViewController(_ url: URL, actions: UsersActions) -> UIViewController {
        UsersListViewController.create(with: followersViewModel(url, actions: actions))
    }

    func followingViewController(_ url: URL, actions: UsersActions) -> UIViewController {
        UsersListViewController.create(with: followingViewModel(url, actions: actions))
    }

    func repositoriesViewController(_ url: URL, actions: RepositoriesActions) -> UIViewController {
        RepositoriesViewController.create(with: repositoriesViewModel(url, actions: actions))
    }

    func starredViewController(_ url: URL, actions: RepositoriesActions) -> UIViewController {
        RepositoriesViewController.create(with: starredViewModel(url, actions: actions))
    }

    func subscriptionsViewControler() -> UIViewController {
        MySubscriptionsViewController.create(with: subscriptionsViewModel())
    }
}

private extension MyProfileFactoryImpl {
    func profileViewModel(_ actions: ProfileActions) -> ProfileViewModel {
        return ProfileViewModelImpl(useCase: profileUseCase, actions: actions)
    }

    func followersViewModel(_ url: URL, actions: UsersActions) -> UsersViewModel {
        UsersViewModelImpl(.followers(url), useCase: listUseCase, actions: actions)
    }

    func followingViewModel(_ url: URL, actions: UsersActions) -> UsersViewModel {
        UsersViewModelImpl(.following(url), useCase: listUseCase, actions: actions)
    }

    func repositoriesViewModel(_ url: URL, actions: RepositoriesActions) -> RepositoriesViewModel {
       RepositoriesViewModelImpl(url, useCase: listUseCase, actions: actions)
    }

    func starredViewModel(_ url: URL, actions: RepositoriesActions) -> RepositoriesViewModel {
        RepositoriesViewModelImpl(url, useCase: listUseCase, actions: actions)
    }

    func subscriptionsViewModel() -> MySubscriptionsViewModel {
        MySubscriptionsViewModelImpl(myProfileUseCase: profileUseCase)
    }

    var profileUseCase: MyProfileUseCase {
        MyProfileUseCaseImpl(profileRepository: profileRepository)
    }

    var listUseCase: ListUseCase {
        ListUseCaseImpl(repository: listRepository)
    }

    var listRepository: ListRepository {
        ListRepositoryImpl(dataTransferService: dataTransferService)
    }

    var profileRepository: MyProfileRepository {
        MyProfileRepositoryImpl(dataTransferService: dataTransferService, localStorage: storage)
    }
}
