//
//  MyProfileFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import UIKit

protocol MyProfileFactory {
    func profileViewController(_ actions: ProfileActions) -> UIViewController
    func followersViewController(_ actions: UsersListActions) -> UIViewController
    func followingViewController(_ actions: UsersListActions) -> UIViewController
    func repositoriesViewController(_ actions: MyRepositoriesActions) -> UIViewController
    func starredViewController(_ actions: MyRepositoriesActions) -> UIViewController
    func eventsViewController(_ actions: EventsActions, user: User) -> UIViewController
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
    func profileViewController(_ actions: ProfileActions) -> UIViewController {
        ProfileViewController.create(with: profileViewModel(actions))
    }

    func followersViewController(_ actions: UsersListActions) -> UIViewController {
        UIViewController()
    }

    func followingViewController(_ actions: UsersListActions) -> UIViewController {
        UIViewController()
    }

    func repositoriesViewController(_ actions: MyRepositoriesActions) -> UIViewController {
        MyRepositoriesViewController.create(with: repositoriesViewModel(actions))
    }

    func starredViewController(_ actions: MyRepositoriesActions) -> UIViewController {
        MyRepositoriesViewController.create(with: starredViewModel(actions))
    }

    func eventsViewController(_ actions: EventsActions, user: User) -> UIViewController {
        UIViewController()
    }
}

private extension MyProfileFactoryImpl {
    func profileViewModel(_ actions: ProfileActions) -> ProfileViewModel {
        return ProfileViewModelImpl(useCase: profileUseCase, actions: actions)
    }

    func repositoriesViewModel(_ actions: MyRepositoriesActions) -> MyRepositoriesViewModel {
        MyRepositoriesViewModelImpl(myProfileUseCase: profileUseCase, type: .all, actions: actions)
    }

    func starredViewModel(_ actions: MyRepositoriesActions) -> MyRepositoriesViewModel {
        MyRepositoriesViewModelImpl(myProfileUseCase: profileUseCase, type: .starred, actions: actions)
    }

    var profileUseCase: MyProfileUseCase {
        MyProfileUseCaseImpl(profileRepository: profileRepository)
    }

    var profileRepository: MyProfileRepository {
        MyProfileRepositoryImpl(dataTransferService: dataTransferService, localStorage: storage)
    }
}
