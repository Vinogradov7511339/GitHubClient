//
//  RepRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

protocol RepRepository {

    // MARK: - Repositories

    typealias RepListHandler = (Result<RepListResponseModel, Error>) -> Void
    func fetchRepList(request: RepListRequestModel, completion: @escaping RepListHandler)

    typealias RepHandler = (Result<Repository, Error>) -> Void
    func fetchRepository(repository: Repository, completion: @escaping RepHandler)

    // MARK: - Branches

    typealias BranchesHandler = (Result<BranchesResponseModel, Error>) -> Void
    func fetchBranches(request: BranchesRequestModel, completion: @escaping BranchesHandler)

    // MARK: - Commits

    typealias CommitsHandler = (Result<CommitsResponseModel, Error>) -> Void
    func fetchCommits(request: CommitsRequestModel, completion: @escaping CommitsHandler)

    typealias CommitHandler = (Result<ExtendedCommit, Error>) -> Void
    func fetchCommit(request: CommitRequestModel, completion: @escaping CommitHandler)

    // MARK: - Content

    typealias ContentHandler = (Result<[FolderItem], Error>) -> Void
    func fetchContent(path: URL, completion: @escaping ContentHandler)

    typealias FileHandler = (Result<File, Error>) -> Void
    func fetchFile(path: URL, completion: @escaping FileHandler)
    func fetchReadMe(repository: Repository, completion: @escaping FileHandler)

    // MARK: - Issues

    typealias IssuesHandler = (Result<IssuesResponseModel, Error>) -> Void
    func fetchIssues(request: IssuesRequestModel, completion: @escaping IssuesHandler)

    typealias IssueHandler = (Result<IssueResponseModel, Error>) -> Void
    func fetchIssue(request: IssueRequestModel, completion: @escaping IssueHandler)

    // MARK: - Pull Requests

    typealias PRListHandler = (Result<PRListResponseModel, Error>) -> Void
    func fetchPRList(request: PRListRequestModel, completion: @escaping PRListHandler)

    typealias PRHandler = (Result<PullRequest, Error>) -> Void
    func fetchPR(request: PRRequestModel, completion: @escaping PRHandler)

    // MARK: - Releases

    typealias ReleasesHandler = (Result<ReleasesResponseModel, Error>) -> Void
    func fetchReleases(request: ReleasesRequestModel, completion: @escaping ReleasesHandler)

    typealias ReleaseHandler = (Result<Release, Error>) -> Void
    func fetchRelease(request: ReleaseRequestModel, completion: @escaping ReleaseHandler)

    // MARK: - License

    typealias LicenseHandler = (Result<LicenseResponseDTO, Error>) -> Void
    func fetchLicense(request: LicenseRequestModel, completion: @escaping LicenseHandler)

    // MARK: - Watchers

    typealias WatchersHandler = (Result<WatchersResponseModel, Error>) -> Void
    func fetchWatchers(request: WatchersRequestModel, completion: @escaping WatchersHandler)

    // MARK: - Forks

    typealias ForksHandler = (Result<ForksResponseModel, Error>) -> Void
    func fetchForks(request: ForksRequestModel, completion: @escaping ForksHandler)

    // MARK: - Comments

    typealias CommentsHandler = (Result<CommentsResponseModel, Error>) -> Void
    func fetchIssueComments(request: CommentsRequestModel<Issue>, completion: @escaping CommentsHandler)
    func fetchPullRequestComments(request: CommentsRequestModel<PullRequest>, completion: @escaping CommentsHandler)
    func fetchCommitComments(request: CommentsRequestModel<Commit>, completion: @escaping CommentsHandler)
}
