//
//  ProfileViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import UIKit

struct ProfileActions {
    let openSettings: () -> Void
    let showFollowers: (URL) -> Void
    let showFollowing: (URL) -> Void
    let showRepositories: (URL) -> Void
    let showStarred: (URL) -> Void
    let showSubscriptions: () -> Void
    let showEvents: (URL, URL) -> Void
    let sendEmail: (String) -> Void
    let openLink: (URL) -> Void
    let share: (URL) -> Void

    let showRepository: (URL) -> Void
    let showUser: (URL) -> Void
}

protocol ProfileViewModelInput {
    func viewDidLoad()
    func refresh()
    func share()
    func openSettings()
    func showFollowers()
    func showFollowing()
    func showEditProfile()
    func openLink(_ link: URL)
    func sendEmail()

    func openRepositories()
    func openStarred()
    func openSubscriptions()
    func openEvents()
}

enum MyProfileScreenState {
    case loaded(AuthenticatedUser)
    case error(Error)
    case loading
}

protocol ProfileViewModelOutput {
    var state: Observable<MyProfileScreenState> { get }
}

typealias ProfileViewModel = ProfileViewModelInput & ProfileViewModelOutput

final class ProfileViewModelImpl: ProfileViewModel {

    // MARK: - Output

    var state: Observable<MyProfileScreenState> = Observable(.loading)

    // MARK: - Private

    private let useCase: MyProfileUseCase
    private let actions: ProfileActions

    init(useCase: MyProfileUseCase, actions: ProfileActions) {
        self.useCase = useCase
        self.actions = actions
    }
}

// MARK: - Output
extension ProfileViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func refresh() {
        fetch()
    }

    func share() {}

    func openSettings() {
        actions.openSettings()
    }

    func showFollowers() {
        guard case .loaded(let profile) = state.value else { return }
        actions.showFollowers(profile.userDetails.followersUrl)
    }

    func showFollowing() {
        guard case .loaded(let profile) = state.value else { return }
        actions.showFollowing(profile.userDetails.followingUrl)
    }

    func showEditProfile() {}

    func openLink(_ link: URL) {
        if link.isRepository {
            actions.showRepository(link)
        }
    }

    func sendEmail() {}

    func openRepositories() {
        guard let url = URL(string: "https://api.github.com/user/repos") else { return }
        actions.showRepositories(url)
    }

    func openStarred() {
        guard case .loaded(let profile) = state.value else { return }
        actions.showStarred(profile.userDetails.starredUrl)
    }

    func openSubscriptions() {
        actions.showSubscriptions()
    }

    func openEvents() {
        guard case .loaded(let profile) = state.value else { return }
        actions.showEvents(profile.userDetails.eventsUrl, profile.userDetails.receivedEventsUrl)
    }
}

private extension ProfileViewModelImpl {
    func fetch() {
        useCase.fetchProfile { result in
            switch result {
            case .success(let user):
                self.state.value = .loaded(user)
            case .failure(let error):
                self.state.value = .error(error)
            }
        }
    }
}
