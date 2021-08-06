//
//  UsersListPresenter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.07.2021.
//

import UIKit

protocol UsersListPresenterInput {
    var output: UsersListPresenterOutput? { get set }
    var type: UsersListType { get }
    
    func viewDidLoad()
    func refresh()
    func didSelectItem(at indexPath: IndexPath)
}

protocol UsersListPresenterOutput: AnyObject {
    func display(viewModels: [Any])
    func push(to viewController: UIViewController)
}

class UsersListPresenter {
    
    weak var output: UsersListPresenterOutput?
    var interactor: UsersListInteractorInput?
    let type: UsersListType
    
    private var users: [UserResponseDTO] = []
    
    init(type: UsersListType) {
        self.type = type
    }
}

// MARK: - UsersListPresenterInput
extension UsersListPresenter: UsersListPresenterInput {
    func viewDidLoad() {
        interactor?.fetchUsers()
    }
    
    func refresh() {
        interactor?.fetchUsers()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let user = users[indexPath.row]
        let viewController = ProfileConfigurator.createProfileModule(with: .notMyProfile(profile: user))
        output?.push(to: viewController)
    }
}

// MARK: - UsersListInteractorOutput
extension UsersListPresenter: UsersListInteractorOutput {
    func didReceive(users: [UserResponseDTO]) {
        self.users = users
        output?.display(viewModels: users)
    }
}
