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
    func didSelectItem(at indexPath: IndexPath)
}

protocol ProfileViewModelOutput {
    var cellManager: TableCellManager { get }
    var tableItems: Observable<[[Any]]> { get }
}

typealias ProfileViewModel = ProfileViewModelInput & ProfileViewModelOutput

final class ProfileViewModelImpl: ProfileViewModel {

    // MARK: - Output
    
    let cellManager: TableCellManager
    let tableItems: Observable<[[Any]]> = Observable(ProfileViewModelImpl.items())

    // MARK: - Private

    private let useCase: MyProfileUseCase
    private let actions: ProfileActions
    
    init(useCase: MyProfileUseCase, actions: ProfileActions) {
        self.useCase = useCase
        self.actions = actions
        cellManager = TableCellManager.create(cellType: TableViewCell.self)
    }
}

extension ProfileViewModelImpl {
    func viewDidLoad() {
        useCase.fetch { result in
        }
    }

    func refresh() {}

    func share() {}

    func openSettings() {}

    func showFollowers() {}

    func showFollowing() {}

    func openLink() {}

    func sendEmail() {}

    func didSelectItem(at indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            actions.showRepositories()
        case (0, 1):
            actions.showStarred()
        case (0, 2):
            actions.showOrganizations()
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
