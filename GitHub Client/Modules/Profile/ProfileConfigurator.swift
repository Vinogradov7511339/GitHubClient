//
//  ProfileConfigurator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.07.2021.
//

import UIKit

class ProfileConfigurator {
    static func createProfileModule() -> ProfileViewController {
        
        let presenter = ProfilePresenter()
        let profileViewController = ProfileViewController()
        profileViewController.presenter = presenter
        profileViewController.presenter?.output = profileViewController
        
        let interactor = ProfileInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        return profileViewController
    }
}
