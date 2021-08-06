//
//  UsersListInteractor.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 26.07.2021.
//

import Foundation

protocol UsersListInteractorInput {
    var output: UsersListInteractorOutput? { get set }
    
    func fetchUsers()
}

protocol UsersListInteractorOutput: AnyObject {
    func didReceive(users: [UserResponseDTO])
}

class UsersListInteractor {
    weak var output: UsersListInteractorOutput?
    
    private let service = ServicesManager.shared.userService
    private let profile: UserResponseDTO
    private let type: UsersListType
    
    init(profile: UserResponseDTO, type: UsersListType) {
        self.profile = profile
        self.type = type
    }
}

extension UsersListInteractor: UsersListInteractorInput {
    func fetchUsers() {
        switch type {
        case .followers:
            fetchFollowers()
        case .following:
            fetchFollowing()
        }
    }
}

// MARK: private
private extension UsersListInteractor {
    func fetchFollowers() {
        service.fetchFollowers(profile) { [weak self] followers, error in
            if let followers = followers {
                Dispatch.DispatchQueue.main.async {
                    self?.output?.didReceive(users: followers)
                }
            }
        }
    }
    
    func fetchFollowing() {
        service.fetchFollowing(profile) { [weak self] following, error in
            if let following = following {
                Dispatch.DispatchQueue.main.async {
                    self?.output?.didReceive(users: following)
                }
            }
        }
    }
}
