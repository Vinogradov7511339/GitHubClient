//
//  ProfileConfigurator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.07.2021.
//

import UIKit

enum ProfileType {
    case myProfile
    case notMyProfile(profile: UserProfile)
}

class ProfileConfigurator {
    static func createProfileModule(with type: ProfileType) -> ProfileViewController {
        let presenter = ProfilePresenter(type: type)
        let profileViewController = ProfileViewController()
        profileViewController.presenter = presenter
        profileViewController.presenter?.output = profileViewController
        
        let interactor = ProfileInteractor(profileType: type)
        interactor.output = presenter
        presenter.interactor = interactor
        return profileViewController
    }
}
