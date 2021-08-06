//
//  UserProfileViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    private var viewModel: UserProfileViewModel!
    
    static func create(with viewModel: UserProfileViewModel) -> UserProfileViewController {
        let viewController = UserProfileViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
