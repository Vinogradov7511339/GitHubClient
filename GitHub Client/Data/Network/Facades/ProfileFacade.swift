//
//  ProfileFacade.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 26.07.2021.
//

import Foundation

struct ProfileInfo {
    let userProfile: UserResponseDTO
    let starredReposCount: Int
    let popularRepos: [RepositoryResponse]
}

class ProfileFacade {
    
    private let service = ServicesManager.shared.userService
//    private let repositoryProfile = ServicesManager.shared.repositoryService
    private let group = DispatchGroup()
    
    private let type: ProfileType
    private var profile: UserResponseDTO?
    private var starredReposCount = 0
    private var popularRepos: [RepositoryResponse] = []
    
    init(type: ProfileType) {
        self.type = type
    }
    
    func fetchProfile(completion: @escaping (ProfileInfo?) -> Void) {
        group.enter()
        group.notify(queue: .main) {
            if let profile = self.profile {
                let info = ProfileInfo(
                    userProfile: profile,
                    starredReposCount: self.starredReposCount,
                    popularRepos: self.popularRepos
                )
                completion(info)
            }
        }
        
        switch type {
        case .myProfile:
            fetchMyProfile()
        case .notMyProfile(let profile):
            fetchProfile(profile: profile)
        }
    }
}

// MARK: - private
private extension ProfileFacade {
    func fetchMyProfile() {
        service.fetchMyProfile { [weak self] profile, error in
            if let profile = profile {
                self?.profile = profile
                self?.fetchStarredReposCount(profile)
                self?.fetchPopularRepos(profile)
                self?.group.leave()
            }
        }
    }

    func fetchProfile(profile: UserResponseDTO) {
        service.fetchProfile(user: profile) { [weak self] profile, error in
            if let profile = profile {
                self?.profile = profile
                self?.fetchStarredReposCount(profile)
                self?.fetchPopularRepos(profile)
                self?.group.leave()
            }
        }
    }

    func fetchStarredReposCount(_ profile: UserResponseDTO) {
        group.enter()
        service.fetchStarredCountRepositories(profile) { [weak self] count, error in
            if let count = count {
                self?.starredReposCount = count
                self?.group.leave()
            }
        }
    }

    func fetchPopularRepos(_ profile: UserResponseDTO) {
        group.enter()
        service.fetchPopularRepositories(profile) { [weak self] repositories, error in
            if let repositories = repositories {
                self?.popularRepos = repositories
                self?.group.leave()
            }
        }
    }
}
