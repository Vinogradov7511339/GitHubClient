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

final class ProfileViewModel {
    
}
