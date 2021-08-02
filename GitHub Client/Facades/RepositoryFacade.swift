//
//  RepositoryFacade.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import Foundation

struct RepositoryInfo {
    let repository: RepositoryResponse
    let pullRequestsCount: Int
    let releasesCount: Int
    let discussionsCount: Int
    let commitsCount: Int
    let readMe: String
}

class RepositoryFacade {
    
    private let repositoryService = ServicesManager.shared.repositoryService
    private let group = DispatchGroup()
    private let repository: RepositoryResponse
    
    private var pullRequestsCount = 0
    private var releasesCount = 0
    private var discussionsCount = 0
    private var commitsCount = 0
    private var decodedReadMe = ""
    private var error: Error? = nil
    
    init(_ repository: RepositoryResponse) {
        self.repository = repository
    }
    
    func fetchInfo(completion: @escaping (RepositoryInfo?, Error?) -> Void) {
        fetchPullRequestsCount()
        fetchReleasesCount()
        fetchDiscussionsCount()
        fetchCommitsCount()
        fetchReadMe()
        group.notify(queue: .main) {
            let info = RepositoryInfo(
                repository: self.repository,
                pullRequestsCount: self.pullRequestsCount,
                releasesCount: self.releasesCount,
                discussionsCount: self.discussionsCount,
                commitsCount: self.commitsCount,
                readMe: self.decodedReadMe
            )
            completion(info, self.error)
        }
    }
}

// MARK: - private
private extension RepositoryFacade {
    func fetchPullRequestsCount() {
        group.enter()
        repositoryService.fetchPullRequestCount(for: repository) { count, error in
            self.pullRequestsCount = count ?? 0
            self.error = error
            self.group.leave()
        }
    }
    
    func fetchReleasesCount() {
        group.enter()
        repositoryService.fetchReleasesCount(for: repository) { count, error in
            self.releasesCount = count ?? 0
            self.error = error
            self.group.leave()
        }
    }
    
    func fetchDiscussionsCount() {
        group.enter()
        repositoryService.fetchDiscussionsCount(for: repository) { count, error in
            self.discussionsCount = count ?? 0
            self.error = error
            self.group.leave()
        }
    }
    
    func fetchCommitsCount() {
        group.enter()
        repositoryService.fetchCommitsCount(for: repository) { count, error in
            self.commitsCount = count ?? 0
            self.error = error
            self.group.leave()
        }
    }
    
    func fetchReadMe() {
        group.enter()
        repositoryService.fetchReadMe(for: repository) { readMeModel, error in
            guard let readMeModel = readMeModel, let decoded = readMeModel.content.fromBase64() else {
                self.error = error
                self.group.leave()
                return
            }
            self.decodedReadMe = decoded
            self.error = error
            self.group.leave()
        }
    }
}
