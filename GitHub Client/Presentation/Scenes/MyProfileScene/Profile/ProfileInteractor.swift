//
//  ProfileInteractor.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.07.2021.
//

import Foundation

protocol ProfileInteractorInput {
    var output: ProfileInteractorOutput? { get set }
    
    func fetchProfile()
}

protocol ProfileInteractorOutput: AnyObject {
    func didReceive(profileInfo: ProfileInfo)
}

class ProfileInteractor {
    
    weak var output: ProfileInteractorOutput?
    
    private let facade: ProfileFacade
    private let localStorage = ServicesManager.shared.localStorage
    private let profileType: ProfileType
    
    private var userProfile: UserResponseDTO?
    private var userRepos: [RepositoryResponse] = []
    private var userPopularRepos: [RepositoryResponse] = []
    private var userStarredRepos: [RepositoryResponse] = []
    private var userFollowers: [UserResponseDTO] = []
    private var userFollowing: [UserResponseDTO] = []
    
    init(profileType: ProfileType) {
        self.profileType = profileType
        facade = ProfileFacade(type: profileType)
    }
}

// MARK: - ProfileInteractorInput
extension ProfileInteractor: ProfileInteractorInput {
    func fetchProfile() {
        facade.fetchProfile { profileInfo in
            if let profileInfo = profileInfo {
                self.output?.didReceive(profileInfo: profileInfo)
            }
        }
    }
}

// MARK: - private
private extension ProfileInteractor {
    func handleError(error: Error?, getFromStorageFunc: ()?) {
//        guard let error = error else {
//            output?.didReceive(error: APIError.unknown)
//            return
//        }
//
//        guard let httpError = error as? HTTPError else {
//            output?.didReceive(error: error)
//            return
//        }
//
//        switch httpError {
//        case .notModified:
//            getFromStorageFunc
//        default:
//            output?.didReceive(error: error)
//        }
    }
}


// MARK: - storage
private extension ProfileInteractor {
    
    func getLocalProfile() {
//        localStorage.getUser {  userDBModel in
//            let user = userDBModel.map { UserProfileAdapter.fromDBModel($0) }
//            self.userProfile = user.first!
//            self.output?.didReceive(profile: user.first!)
//        }
    }
    
    func getLocalPopularRepositories() {
        //todo
    }
    
    func syncStorage(profile: UserResponseDTO) {
//        localStorage.saveUser(user: profile)
    }
    
    func syncStorage(popularRepositories: [RepositoryResponse]) {
//        localStorage.saveUser(user: profile)
    }
}
