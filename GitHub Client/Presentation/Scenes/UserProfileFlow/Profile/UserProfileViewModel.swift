//
//  UserProfileViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

struct UserProfileActions {
    let showFollowers: (URL) -> Void
    let showFollowing: (URL) -> Void

    let sendEmail: (String) -> Void
    let openLink: (URL) -> Void
    let share: (URL) -> Void

    let showRepositories: (URL) -> Void
    let showStarred: (URL) -> Void
    let showGists: (URL) -> Void
    let showEvents: (_ events: URL, _ receivedEvents:URL) -> Void

    let showSubscriptions: (URL) -> Void

}

protocol UserProfileViewModelInput {
    func viewDidLoad()
    func refresh()

    func showFollowers()
    func showFollowing()
    func follow()

    func showRepositories()
    func showStarred()
    func showGists()
    func showEvents()

    func share()
}

protocol UserProfileViewModelOutput {
    var state: Observable<DetailsScreenState<UserProfile>> { get }
}

typealias UserProfileViewModel = UserProfileViewModelInput & UserProfileViewModelOutput

class UserProfileViewModelImpl: UserProfileViewModel {

    // MARK: - Output

    var state: Observable<DetailsScreenState<UserProfile>> = Observable(.loading)

    // MARK: - Private

    private let userUrl: URL
    private let userProfileUseCase: UserProfileUseCase
    private let actions: UserProfileActions

    init(userUrl: URL, userProfileUseCase: UserProfileUseCase, actions: UserProfileActions) {
        self.userUrl = userUrl
        self.userProfileUseCase = userProfileUseCase
        self.actions = actions
    }
}

// MARK: - Output
extension UserProfileViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func refresh() {
        fetch()
    }

    func showFollowers() {
        guard case .loaded(let profile) = state.value else { return }
        actions.showFollowers(profile.followersUrl)
    }

    func showFollowing() {
        guard case .loaded(let profile) = state.value else { return }
        actions.showFollowing(profile.followingUrl)
    }

    func follow() {}

    func showRepositories() {
        guard case .loaded(let profile) = state.value else { return }
        actions.showRepositories(profile.repositoriesUrl)
    }

    func showStarred() {
        guard case .loaded(let profile) = state.value else { return }
        actions.showStarred(profile.starredUrl)
    }

    func showGists() {
        guard case .loaded(let profile) = state.value else { return }
        actions.showGists(profile.gistsUrl)
    }

    func showEvents() {
        guard case .loaded(let profile) = state.value else { return }
        actions.showEvents(profile.eventsUrl, profile.receivedEventsUrl)
    }

    func share() {
        guard case .loaded(let profile) = state.value else { return }
        actions.share(profile.htmlUrl)
    }
}

private extension UserProfileViewModelImpl {
    func fetch() {
        state.value = .loading
        userProfileUseCase.fetchProfile(userUrl) { result in
            switch result {
            case .success(let profile):
                self.state.value = .loaded(profile)
            case .failure(let error):
                self.state.value = .error(error)
            }
        }
    }
}
