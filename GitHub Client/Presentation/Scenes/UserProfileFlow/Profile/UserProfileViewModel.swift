//
//  UserProfileViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

struct UserProfileActions {
    let showRepositories: (URL) -> Void
    let showFollowers: (URL) -> Void
    let showFollowing: (URL) -> Void

    let sendEmail: (String) -> Void
    let openLink: (URL) -> Void
    let share: (URL) -> Void

    let showRecentEvents: (URL) -> Void
    let showStarred: (URL) -> Void
    let showGists: (URL) -> Void
    let showSubscriptions: (URL) -> Void
    let showEvents: (URL) -> Void
}

protocol UserProfileViewModelInput {
    func viewDidLoad()
    func refresh()
}

enum UserScreenState {
    case loaded(UserProfile)
    case error(Error)
    case loading
}

protocol UserProfileViewModelOutput {
    var state: Observable<UserScreenState> { get }
}

typealias UserProfileViewModel = UserProfileViewModelInput & UserProfileViewModelOutput

class UserProfileViewModelImpl: UserProfileViewModel {

    // MARK: - Output

    var state: Observable<UserScreenState> = Observable(.loading)

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
