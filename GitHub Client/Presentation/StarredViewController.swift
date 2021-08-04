//
//  StarredViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class StarredViewController: UIViewController {
    
    private var viewModel: StarredViewModel!

    static func create(with viewModel: StarredViewModel) -> StarredViewController {
        let viewController = StarredViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}
