//
//  RepRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

final class RepRepositoryImpl {
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - RepRepository
extension RepRepositoryImpl: RepRepository {}

// MARK: Repositories
extension RepRepositoryImpl {
    func fetchRepository(_ url: URL, completion: @escaping RepHandler) {
        let endpoint = RepEndpoits.repository(url)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                if let repository = response.model.toDomain() {
                    completion(.success(repository))
                } else {
                    assert(false, "parse error")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Commits
extension RepRepositoryImpl {
    func fetchCommit(_ commitUrl: URL, completion: @escaping CommitHandler) {
        let endpoint = RepEndpoits.commit(commitUrl)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let model):
                completion(.success(model.model.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Content
extension RepRepositoryImpl {
    func fetchContent(path: URL, completion: @escaping ContentHandler) {
        let endpoint = RepEndpoits.folder(path)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let model):
                let items = model.model.map { $0.toDomain() }
                completion(.success(items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchFile(path: URL, completion: @escaping FileHandler) {
        let endpoint = RepEndpoits.file(path)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let model):
                let file = model.model.toDomain()
                completion(.success(file))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchReadMe(repository: Repository, completion: @escaping FileHandler) {
        let endpoint = RepEndpoits.readMe(repository)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let model):
                completion(.success(model.model.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Issues
extension RepRepositoryImpl {
    func fetchIssues(request: IssuesRequestModel, completion: @escaping IssuesHandler) {
        let endpoint = RepEndpoits.issues(request)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let lastPage = response.httpResponse?.lastPage ?? 1
                let items = response.model.compactMap { $0.toDomain() }
                let model = ListResponseModel<Issue>(items: items, lastPage: lastPage)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchIssue(_ issue: Issue, completion: @escaping IssueHandler) {
        let endpoint = RepEndpoits.issue(issue)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                completion(.success(response.model.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchIssueComments(_ request: CommentsRequestModel<Issue>,
                            completion: @escaping IssueCommentsHandler) {
        let endpoint = RepEndpoits.issueComments(request)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let model):
                fatalError()
//                let response = IssueResponseModel(comments: <#T##[Comment]#>, lastPage: <#T##Int#>)
//                completion(.success(model.model.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Pull Requests
extension RepRepositoryImpl {
    func fetchPRList(request: PRListRequestModel, completion: @escaping PRListHandler) {
        let endpoint = RepEndpoits.pullRequests(request)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let lastPage = response.httpResponse?.lastPage ?? 1
                let items = response.model.compactMap { $0.toDomain() }
                let model = ListResponseModel<PullRequest>(items: items, lastPage: lastPage)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchPR(_ pullRequest: PullRequest, completion: @escaping PRHandler) {
        let endpoint = RepEndpoits.pullRequest(pullRequest)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let model):
                completion(.success(model.model.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Releases
extension RepRepositoryImpl {
    func fetchRelease(request: ReleaseRequestModel, completion: @escaping ReleaseHandler) {
        let endpoint = RepEndpoits.release(request)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let model):
                completion(.success(model.model.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - License
extension RepRepositoryImpl {
    func fetchLicense(request: LicenseRequestModel, completion: @escaping LicenseHandler) {
        fatalError()
    }
}

// MARK: - Comments
extension RepRepositoryImpl {
    func fetchIssueComments(request: CommentsRequestModel<Issue>, completion: @escaping CommentsHandler) {
        let endpoint = RepEndpoits.issueComments(request)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let comments = response.model.map { $0.toDomain() }
                let lastPage = response.httpResponse?.lastPage ?? 1
                let model = ListResponseModel<Comment>(items: comments, lastPage: lastPage)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchPullRequestComments(request: CommentsRequestModel<PullRequest>,
                                  completion: @escaping CommentsHandler) {
        fatalError()
    }

    func fetchCommitComments(request: CommentsRequestModel<Commit>,
                             completion: @escaping CommentsHandler) {
        fatalError()
    }
}

// MARK: - Diff
extension RepRepositoryImpl {
    func fetchDiff(_ url: URL, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = RepEndpoits.diff(url)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let model):
                completion(.success(model.model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
