//
//  ProfileInteractor.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.07.2021.
//

import Foundation

protocol ProfileInteractorInput {
    var output: ProfileInteractorOutput? { get set }
    
    func fetchMyProfile()
    func fetchMyPopularRepositories()
    func fetchStarredRepositories()
}

protocol ProfileInteractorOutput: AnyObject {
    func didReceive(profile: UserProfile)
    func didReceive(popularRepositories: [Repository])
    func didReceive(starredRepositories: [Repository])
    func didReceive(error: Error)
}

class ProfileInteractor {
    
    weak var output: ProfileInteractorOutput?
    
    private let profileService = ServicesManager.shared.profileService
    private let repositoryService = ServicesManager.shared.repositoryService
    private let localStorage = ServicesManager.shared.localStorage
    
    private var userProfile: UserProfile?
    private var popularRepositories: [Repository] = []
}

// MARK: - ProfileInteractorInput
extension ProfileInteractor: ProfileInteractorInput {
    func fetchMyProfile() {
        requestProfile()
    }
    
    
    func fetchMyPopularRepositories() {
        requestPopularRepositories()
    }
    
    func fetchStarredRepositories() {
        requestStarredRepositories()
    }
}

// MARK: - private
private extension ProfileInteractor {
    func requestProfile() {
        profileService.getProfile { [weak self] userProfile, error in
            if let userProfile = userProfile {
                self?.userProfile = userProfile
                self?.syncStorage(profile: userProfile)
                self?.output?.didReceive(profile: userProfile)
                return
            }
            
            self?.handleError(error: error, getFromStorageFunc: self?.getLocalProfile())
        }
    }
    
    func requestPopularRepositories() {
        guard let url = userProfile?.repos_url else { return }
        repositoryService.getRepositories(url: url) { [weak self] repositories, error in
            if let repositories = repositories {
                self?.popularRepositories = repositories
                self?.syncStorage(popularRepositories: repositories)
                self?.output?.didReceive(popularRepositories: repositories)
                return
            }
            
            self?.handleError(error: error, getFromStorageFunc: self?.getLocalPopularRepositories())
        }
    }
    
    func requestStarredRepositories() {
        guard let urlStr = userProfile?.starred_url else { return }
        let pattern = "\\{.*\\}"
        let range = urlStr.range(of: pattern, options: .regularExpression)
        let allReposUrl = urlStr.replacingCharacters(in: range!, with: "")
        
        guard let url = URL(string: allReposUrl) else { return }
        repositoryService.getRepositories(url: url) { [weak self] repositories, error in
            if let repositories = repositories {
                self?.popularRepositories = repositories
                self?.syncStorage(popularRepositories: repositories)
                self?.output?.didReceive(starredRepositories: repositories)
                return
            }
            
            self?.handleError(error: error, getFromStorageFunc: self?.getLocalPopularRepositories())
        }
    }
    
    func handleError(error: Error?, getFromStorageFunc: ()?) {
        guard let error = error else {
            output?.didReceive(error: APIError.unknown)
            return
        }
        
        guard let httpError = error as? HTTPError else {
            output?.didReceive(error: error)
            return
        }
        
        switch httpError {
        case .notModified:
            getFromStorageFunc
        default:
            output?.didReceive(error: error)
        }
    }
}


// MARK: - storage
private extension ProfileInteractor {
    
    func getLocalProfile() {
        localStorage.getUser {  userDBModel in
//            let user = userDBModel.map { UserProfileAdapter.fromDBModel($0) }
//            self.userProfile = user.first!
//            self.output?.didReceive(profile: user.first!)
        }
    }
    
    func getLocalPopularRepositories() {
        //todo
    }
    
    func syncStorage(profile: UserProfile) {
//        localStorage.saveUser(user: profile)
    }
    
    func syncStorage(popularRepositories: [Repository]) {
//        localStorage.saveUser(user: profile)
    }
}

//class ProfileInteractor {
//
//    private weak var lastOperation: Operation?
//
//    private lazy var operationQueue: OperationQueue = {
//        let queue = OperationQueue()
//        queue.qualityOfService = .userInitiated
//        return queue
//    }()
//
//
//    private let localStorage = LocalStorage()
//}
//
//private extension ProfileInteractor {
//    func fetchNeededData(for user: UserProfile) {
//        let fetchPopularRepositories = AsyncOperation { handler in
//            //todo
//        }
//        addOperation(fetchPopularRepositories)
//    }
//
//
//
//    func addOperation(_ operation: Operation) {
//        if let lastOperation = lastOperation {
//            operation.addDependency(lastOperation)
//        }
//        lastOperation = operation
//        operationQueue.addOperation(operation)
//    }
//}
