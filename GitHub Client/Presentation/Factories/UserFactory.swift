//
//  UsersListFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 12.08.2021.
//

import UIKit

protocol UserFactory {
    func profileViewController(userUrl: URL, _ actions: UserProfileActions) -> UIViewController
    func followersViewController(_ url: URL, _ actions: UsersActions) -> UIViewController
    func followingViewController(_ url: URL, _ actions: UsersActions) -> UIViewController
    func repositoriesViewController(_ url: URL, _ actions: RepositoriesActions) -> UIViewController
    func starredViewController(_ url: URL, _ actions: RepositoriesActions) -> UIViewController
    func gistsViewController(_ url: URL) -> UIViewController
    func subscriptionsViewController(_ url: URL) -> UIViewController
    func eventsViewController(_ eventsUrl: URL,
                              _ recivedEventsUrl: URL,
                              actions: EventsActions) -> UIViewController
}

final class UsersListFactoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - UsersListFactory
extension UsersListFactoryImpl: UserFactory {
    func gistsViewController(_ url: URL) -> UIViewController {
        UIViewController()
    }

    func subscriptionsViewController(_ url: URL) -> UIViewController {
        UIViewController()
    }

    func eventsViewController(_ eventsUrl: URL, _ recivedEventsUrl: URL, actions: EventsActions) -> UIViewController {
        let eventsViewModel = eventsViewModel(eventsUrl, actions: actions)
        let recivedEventsViewModel = receivedEventsViewModel(recivedEventsUrl, actions: actions)
        return EventsViewController.create(events: eventsViewModel, received: recivedEventsViewModel)
    }

    func profileViewController(userUrl: URL, _ actions: UserProfileActions) -> UIViewController {
        UserProfileViewController.create(with: userProfileViewModel(userUrl: userUrl, actions: actions))
    }

    func followersViewController(_ url: URL, _ actions: UsersActions) -> UIViewController {
        UsersListViewController.create(with: followersViewModel(url, actions: actions))
    }

    func followingViewController(_ url: URL, _ actions: UsersActions) -> UIViewController {
        UsersListViewController.create(with: followingViewModel(url, actions: actions))
    }

    func repositoriesViewController(_ url: URL, _ actions: RepositoriesActions) -> UIViewController {
        RepositoriesViewController.create(with: repositoriesViewModel(url, actions: actions))
    }

    func starredViewController(_ url: URL, _ actions: RepositoriesActions) -> UIViewController {
        RepositoriesViewController.create(with: repositoriesViewModel(url, actions: actions))
    }
}

private extension UsersListFactoryImpl {
    func userProfileViewModel(userUrl: URL, actions: UserProfileActions) -> UserProfileViewModel {
        return UserProfileViewModelImpl(userUrl: userUrl,
                                        userProfileUseCase: userUseCase,
                                        actions: actions)
    }

    func followersViewModel(_ url: URL, actions: UsersActions) -> UsersViewModel {
        UsersViewModelImpl.init(.followers(url), useCase: listUseCase, actions: actions)
    }

    func followingViewModel(_ url: URL, actions: UsersActions) -> UsersViewModel {
        UsersViewModelImpl.init(.following(url), useCase: listUseCase, actions: actions)
    }

    func repositoriesViewModel(_ url: URL, actions: RepositoriesActions) -> RepositoriesViewModel {
        RepositoriesViewModelImpl(.repositories(url), useCase: listUseCase, actions: actions)
    }

    func starredViewModel(_ url: URL, actions: RepositoriesActions) -> RepositoriesViewModel {
        RepositoriesViewModelImpl(.starred(url), useCase: listUseCase, actions: actions)
    }

    func eventsViewModel(_ url: URL, actions: EventsActions) -> EventsViewModel {
        EventsViewModelImpl(.events(url), usecase: listUseCase, actions: actions)
    }

    func receivedEventsViewModel(_ url: URL, actions: EventsActions) -> EventsViewModel {
        EventsViewModelImpl(.recentEvents(url), usecase: listUseCase, actions: actions)
    }

    var listUseCase: ListUseCase {
        ListUseCaseImpl(repository: listRepository)
    }

    var listRepository: ListRepository {
        ListRepositoryImpl(dataTransferService: dataTransferService)
    }

    var userUseCase: UserProfileUseCase {
        UserProfileUseCaseImpl(userRepository: userRepository)
    }

    var userRepository: UserRepository {
        UserProfileRepositoryImpl(dataTransferService: dataTransferService)
    }
}
