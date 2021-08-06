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
    let tableItems: Observable<[[Any]]> = Observable([[]])
    
    // MARK: - Private
    
    private let useCase: MyProfileUseCase
    private let actions: ProfileActions
    
    init(useCase: MyProfileUseCase, actions: ProfileActions) {
        self.useCase = useCase
        self.actions = actions
        cellManager = TableCellManager.create(cellType: DetailTableViewCell.self)
    }
}

extension ProfileViewModelImpl {
    func viewDidLoad() {
        useCase.fetch { result in
        }
    }
    
    func refresh() {
        
    }
    
    func share() {
        
    }
    
    func openSettings() {
        
    }
    
    func showFollowers() {

    }
    
    func showFollowing() {
        
    }
    
    
    func openLink() {
        
    }
    
    func sendEmail() {
        
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        
    }

    func items() -> [[DetailCellViewModel]] {
        return [
            [DetailCellViewModel()]

        ]
    }
}
