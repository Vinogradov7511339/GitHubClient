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
    let showOrganizations: () -> Void
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
    var cellManager: TableCellManager { get }
    var tableItems: Observable<[Any]> { get }
    var user: Observable<UserDetails?> { get }
    var events: Observable<[Event]> { get }
}

typealias ProfileViewModel = ProfileViewModelInput & ProfileViewModelOutput

final class ProfileViewModelImpl: ProfileViewModel {

    // MARK: - Output

    let cellManager: TableCellManager
    let tableItems: Observable<[Any]> = Observable(ProfileViewModelImpl.items())
    var user: Observable<UserDetails?> = Observable(nil)
    var events: Observable<[Event]> = Observable([])

    // MARK: - Private

    private let useCase: MyProfileUseCase
    private let actions: ProfileActions

    init(useCase: MyProfileUseCase, actions: ProfileActions) {
        self.useCase = useCase
        self.actions = actions
        cellManager = TableCellManager.create(cellType: BaseDetailsCell.self)
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

    func openSettings() {}

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
        case (0, 0):
            actions.showRepositories()
        case (0, 1):
            actions.showStarred()
        case (0, 2):
            actions.showOrganizations()
        case (0, 3):
            actions.showFollowing()
        case (1, 0):
            actions.showFollowing()
        case (1, 1):
            actions.showFollowers()
        case (2, 0):
            actions.openSettings()
        default:
            break
        }
    }

    static func items() -> [BaseDetailsCellViewModel] {
        return [.repositories, .starred, .organizations, .following]
    }
}

private extension ProfileViewModelImpl {
    func fetch() {
        useCase.fetch { result in
            switch result {
            case .success(let user):
                self.user.value = user.userDetails
                self.fetch(user: user.userDetails.user)
            case .failure(let error):
                self.handle(error: error)
            }
        }
    }

    func fetch(user: User) {
        let request = UserEventsRequestModel(user: user, page: 1)
        useCase.fetchEvents(request: request) { result in
            switch result {
            case .success(let events):
                self.events.value = events
            case .failure(let error):
                self.handle(error: error)
            }
        }
    }

    func handle(error: Error) {

    }
}
