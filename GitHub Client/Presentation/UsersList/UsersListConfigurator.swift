//
//  UsersListConfigurator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.07.2021.
//

import UIKit



class UsersListConfigurator {
    static func createModule(profile: UserProfile, type: UsersListType) -> UsersListViewController {
        let interactor = UsersListInteractor(profile: profile, type: type)
        let presenter = UsersListPresenter(type: type)
        presenter.interactor = interactor
        presenter.interactor?.output = presenter
        
        let viewController = UsersListViewController()
//        viewController.presenter = presenter
//        viewController.presenter.output = viewController
        return viewController
    }
}
