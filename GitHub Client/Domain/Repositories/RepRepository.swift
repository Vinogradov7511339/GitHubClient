//
//  RepRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

protocol RepRepository {

    // MARK: - Repositories

    typealias RepHandler = (Result<Repository, Error>) -> Void
    func fetchRepository(_ url: URL, completion: @escaping RepHandler)

    // MARK: - Commits

    typealias CommitHandler = (Result<Commit, Error>) -> Void
    func fetchCommit(_ commitUrl: URL, completion: @escaping CommitHandler)

    // MARK: - Content

    typealias ContentHandler = (Result<[FolderItem], Error>) -> Void
    func fetchContent(path: URL, completion: @escaping ContentHandler)

    typealias FileHandler = (Result<File, Error>) -> Void
    func fetchFile(path: URL, completion: @escaping FileHandler)
    func fetchReadMe(repository: Repository, completion: @escaping FileHandler)

    // MARK: - Issues

    typealias IssuesHandler = (Result<ListResponseModel<Issue>, Error>) -> Void
    func fetchIssues(request: IssuesRequestModel, completion: @escaping IssuesHandler)

    typealias IssueHandler = (Result<Issue, Error>) -> Void
    func fetchIssue(_ issue: URL, completion: @escaping IssueHandler)

    typealias IssueCommentsHandler = (Result<ListResponseModel<Comment>, Error>) -> Void
    func fetchIssueComments(_ request: CommentsRequestModel<Issue>,
                            completion: @escaping IssueCommentsHandler)

    // MARK: - Pull Requests

    typealias PRListHandler = (Result<ListResponseModel<PullRequest>, Error>) -> Void
    func fetchPRList(request: PRListRequestModel, completion: @escaping PRListHandler)

    typealias PRHandler = (Result<PullRequestDetails, Error>) -> Void
    func fetchPR(_ pullRequest: PullRequest, completion: @escaping PRHandler)

    // MARK: - Releases

    typealias ReleaseHandler = (Result<Release, Error>) -> Void
    func fetchRelease(request: ReleaseRequestModel, completion: @escaping ReleaseHandler)

    // MARK: - License

    typealias LicenseHandler = (Result<LicenseResponseDTO, Error>) -> Void
    func fetchLicense(request: LicenseRequestModel, completion: @escaping LicenseHandler)

    // MARK: - Comments

    typealias CommentsHandler = (Result<ListResponseModel<Comment>, Error>) -> Void
    func fetchIssueComments(request: CommentsRequestModel<Issue>, completion: @escaping CommentsHandler)
    func fetchPullRequestComments(request: CommentsRequestModel<PullRequest>,
                                  completion: @escaping CommentsHandler)
    func fetchCommitComments(request: CommentsRequestModel<Commit>, completion: @escaping CommentsHandler)

    // MARK: - Diff
    func fetchDiff(_ url: URL, completion: @escaping (Result<String, Error>) -> Void)
}
