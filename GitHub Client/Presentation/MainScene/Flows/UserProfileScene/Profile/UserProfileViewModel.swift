//
//  UserProfileViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

struct UserProfileActions {
    let showRepositories: (User) -> Void
    let showFollowers: (User) -> Void
    let showFollowing: (User) -> Void

    let sendEmail: (String) -> Void
    let openLink: (URL) -> Void
    let share: (URL) -> Void

    let showRecentEvents: (User) -> Void
    let showStarred: (User) -> Void
    let showGists: (User) -> Void
    let showSubscriptions: (User) -> Void
    let showOrganizations: (User) -> Void
    let showEvents: (User) -> Void
}

protocol UserProfileViewModelInput: ProfileHeaderViewDelegate {
    func viewDidLoad()
    func refresh()
    func share()
    func openLink(_ link: URL)
    func sendEmail(_ email: String)
    func didSelectItem(at indexPath: IndexPath)
}

protocol UserProfileViewModelOutput {
    var tableItems: Observable<[[Any]]> { get }
    var userDetails: Observable<UserProfile?> { get }
    var backButtonTouchedState: Observable<Bool> { get }

    func register(_ tableView: UITableView)
    func cellManager(for indexPath: IndexPath) -> TableCellManager
}

typealias UserProfileViewModel = UserProfileViewModelInput & UserProfileViewModelOutput

class UserProfileViewModelImpl: UserProfileViewModel {

    // MARK: - Output

    let tableItems: Observable<[[Any]]> = Observable([[]])
    var userDetails: Observable<UserProfile?> = Observable(nil)
    var backButtonTouchedState: Observable<Bool> = Observable(false)

    // MARK: - Private

    private let user: User
    private let userProfileUseCase: UserProfileUseCase
    private let actions: UserProfileActions
    private let cellManagers: [TableCellManager] = [
        TableCellManager.create(cellType: CellWithCollection.self),
        TableCellManager.create(cellType: MenuItemCell.self)
    ]

    init(user: User, userProfileUseCase: UserProfileUseCase, actions: UserProfileActions) {
        self.user = user
        self.userProfileUseCase = userProfileUseCase
        self.actions = actions
    }
}

// MARK: - Output
extension UserProfileViewModelImpl {
    func register(_ tableView: UITableView) {
        cellManagers.forEach { $0.register(tableView: tableView) }
    }

    func cellManager(for indexPath: IndexPath) -> TableCellManager {
        if indexPath.section == 0 {
            return cellManagers[0]
        } else {
            return cellManagers[1]
        }
    }

    func viewDidLoad() {
        fetch()
    }

    func refresh() {
        fetch()
    }

    func share() {}

    func showFollowers() {
        actions.showFollowers(user)
    }

    func showFollowing() {
        actions.showFollowing(user)
    }

    func openLink(_ link: URL) {
        actions.openLink(link)
    }

    func sendEmail(_ email: String) {
        actions.sendEmail(email)
    }

    func showRepositories() {
        actions.showRepositories(user)
    }

    func didSelectItem(at indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            actions.showRecentEvents(user)
        case (1, 0):
            actions.showStarred(user)
        case (1, 1):
            actions.showGists(user)
        case (2, 0):
            actions.showSubscriptions(user)
        case (2, 1):
            actions.showOrganizations(user)
        case (2, 2):
            actions.showEvents(user)
        default:
            break
        }
    }
}

// MARK: - ProfileHeaderViewDelegate
extension UserProfileViewModelImpl: ProfileHeaderViewDelegate {
    func backButtonTouched() {
        backButtonTouchedState.value = true
    }

    func subscribeButtonTouched() {}

    func gistsButtonTouched() {}

    func followersButtonTouched() {
        actions.showFollowers(user)
    }

    func followingButtonTouched() {
        actions.showFollowing(user)
    }
}

private extension UserProfileViewModelImpl {
    func fetch() {
        userProfileUseCase.fetchProfile(user) { result in
            switch result {
            case .success(let user):
                self.updateItems(user)
                self.userDetails.value = user
            case .failure(let error):
                self.handle(error: error)
            }
        }
    }

    func handle(error: Error) {
        assert(false, error.localizedDescription)
    }

    func updateItems(_ user: UserProfile) {
        let starred = MenuItemViewModel.ItemType.starred.viewModel
        let gists = MenuItemViewModel.ItemType.gists(user.gistsCount).viewModel
        let subscriptions = MenuItemViewModel.ItemType.subscriptions.viewModel
        let organizations = MenuItemViewModel.ItemType.organizations.viewModel
        let events = MenuItemViewModel.ItemType.events.viewModel
        let recentEvents = CellWithCollectionViewModel()
        tableItems.value = [[recentEvents], [starred, gists], [subscriptions, organizations, events]]
    }
}
