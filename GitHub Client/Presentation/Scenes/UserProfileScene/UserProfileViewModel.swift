//
//  UserProfileViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

struct UserProfileActions {
    let showFollowers: (User) -> Void
    let showFollowing: (User) -> Void
    let showRepository: (Repository) -> Void
    let showRepositories: (User) -> Void
    let showStarred: (User) -> Void
    let showOrganizations: (User) -> Void
    let sendEmail: (String) -> Void
    let openLink: (URL) -> Void
    let share: (URL) -> Void
}

protocol UserProfileViewModelInput {
    func viewDidLoad()
    func refresh()
    func share()
    func showFollowers()
    func showFollowing()
    func openLink()
    func sendEmail()
    func didSelectItem(at indexPath: IndexPath)
}

protocol UserProfileViewModelOutput {
    var cellManager: TableCellManager { get }
    var tableItems: Observable<[[Any]]> { get }
    var userDetails: Observable<UserDetails?> { get }
}

typealias UserProfileViewModel = UserProfileViewModelInput & UserProfileViewModelOutput

class UserProfileViewModelImpl: UserProfileViewModel {

    // MARK: - Output

    let cellManager: TableCellManager
    let tableItems: Observable<[[Any]]> = Observable(UserProfileViewModelImpl.items())
    var userDetails: Observable<UserDetails?> = Observable(nil)

    // MARK: - Private

    private let user: User
    private let userProfileUseCase: UserProfileUseCase
    private let actions: UserProfileActions


    init(user: User, userProfileUseCase: UserProfileUseCase, actions: UserProfileActions) {
        self.user = user
        self.userProfileUseCase = userProfileUseCase
        self.actions = actions
        cellManager = TableCellManager.create(cellType: TableViewCell.self)
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

    func share() {}

    func showFollowers() {}

    func showFollowing() {}

    func openLink() {}

    func sendEmail() {}

    func didSelectItem(at indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            actions.showRepositories(user)
        case (0, 1):
            actions.showStarred(user)
        case (0, 2):
            actions.showOrganizations(user)
        case (1, 0):
            actions.showFollowing(user)
        case (1, 1):
            actions.showFollowers(user)
        default:
            break
        }
    }

    static func items() -> [[TableCellViewModel]] {
        return [
            [TableCellViewModel(text: "Repositories", detailText: "text2"),
             TableCellViewModel(text: "Starred", detailText: "text2"),
             TableCellViewModel(text: "Organizations", detailText: "text2")],
            [TableCellViewModel(text: "Following", detailText: "text2"),
             TableCellViewModel(text: "Followers", detailText: "text2"),
             TableCellViewModel(text: "Language", detailText: "text2")],
            [TableCellViewModel(text: "Settings", detailText: "text2")]
        ]
    }
}

private extension UserProfileViewModelImpl {
    func fetch() {
        userProfileUseCase.fetch(user: user) { result in
            switch result {
            case .success(let user):
                self.userDetails.value = user
            case .failure(let error):
                self.handle(error: error)
            }
        }
    }

    func handle(error: Error) {

    }
}
