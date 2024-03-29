//
//  SettingsViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

struct SettingsActions {
    var showAccount: () -> Void
}

protocol SettingsViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
}

protocol SettingsViewModelOutput {
    var profile: Observable<AuthenticatedUser?> { get }
}

typealias SettingsViewModel = SettingsViewModelInput & SettingsViewModelOutput

final class SettingsViewModelImpl: SettingsViewModel {

    // MARK: - Output

    var profile: Observable<AuthenticatedUser?>  = Observable(nil)

    // MARK: - Private variables

    private let actions: SettingsActions

    // MARK: - Lifecycle

    init(actions: SettingsActions) {
        self.actions = actions

//        let avatarUrl = URL(string: "https://avatars.githubusercontent.com/u/26507891?v=4")!
//        let mockUser = User(id: 1, login: "Sashko", avatarUrl: avatarUrl, url: avatarUrl, type: .user)
//        let mockUserProfile = UserProfile(user: mockUser, name: nil, bio: nil, location: nil, company: nil, userBlogUrl: nil, userEmail: nil, followingCount: 0, followersCount: 0, gistsCount: 0, repositoriesCount: 0, lastEvents: [])
//        let mockAuthenticatedUser = AuthenticatedUser(userDetails: mockUserProfile, totalRepCount: 0, totalOwnedRepCount: 0)
//        profile = Observable(mockAuthenticatedUser)
    }
}

// MARK: - Input
extension SettingsViewModelImpl {
    func viewDidLoad() {}

    func didSelectItem(at indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            actions.showAccount()
        default:
            break
        }
    }
}
