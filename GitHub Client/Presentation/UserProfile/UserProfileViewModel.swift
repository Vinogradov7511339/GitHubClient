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
    
}

protocol UserProfileViewModelOutput {
    
}

typealias UserProfileViewModel = UserProfileViewModelInput & UserProfileViewModelOutput

class UserProfileViewModelImpl: UserProfileViewModel {

    private let user: User
    private let userProfileUseCase: UserProfileUseCase
    private let actions: UserProfileActions

    init(user: User, userProfileUseCase: UserProfileUseCase, actions: UserProfileActions) {
        self.user = user
        self.userProfileUseCase = userProfileUseCase
        self.actions = actions
    }
}
