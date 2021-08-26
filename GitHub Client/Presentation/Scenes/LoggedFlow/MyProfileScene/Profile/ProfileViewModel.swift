//
//  ProfileViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import UIKit

struct ProfileActions {
    let openSettings: () -> Void
    let showFollowers: () -> Void
    let showFollowing: () -> Void
    let showRepository: (Repository) -> Void
    let showRepositories: () -> Void
    let showStarred: () -> Void
    let showSubscriptions: () -> Void
    let sendEmail: (String) -> Void
    let openLink: (URL) -> Void
    let share: (URL) -> Void
}

protocol ProfileViewModelInput {
    func viewDidLoad()
    func refresh()
    func share()
    func openSettings()
    func showFollowers()
    func showFollowing()
    func openLink()
    func sendEmail()
    func openRepositories()
    func openStarred()
    func didSelectItem(at indexPath: IndexPath)
}

protocol ProfileViewModelOutput {
    var user: Observable<UserProfile?> { get }
}

typealias ProfileViewModel = ProfileViewModelInput & ProfileViewModelOutput

final class ProfileViewModelImpl: ProfileViewModel {

    // MARK: - Output

    var user: Observable<UserProfile?> = Observable(nil)

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
        actions.showFollowers()
    }

    func showFollowing() {
        actions.showFollowing()
    }

    func openLink() {}

    func sendEmail() {}

    func openRepositories() {
        actions.showRepositories()
    }

    func openStarred() {
        actions.showStarred()
    }

    func didSelectItem(at indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (1, 0):
            actions.showRepositories()
        case (1, 1):
            actions.showStarred()
        case (1, 2):
            assert(false, "update models")
        case (1, 3):
            actions.showSubscriptions()
        default:
            break
        }
    }
}

private extension ProfileViewModelImpl {
    func fetch() {
        useCase.fetchProfile { result in
            switch result {
            case .success(let user):
                self.user.value = user.userDetails
            case .failure(let error):
                self.handle(error: error)
            }
        }
    }

    func handle(error: Error) {

    }
}
