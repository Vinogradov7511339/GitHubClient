//
//  PRViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

struct PRActions {}

protocol PRViewModelInput {
    func viewDidLoad()
    func refresh()
}

protocol PRViewModelOutput {
    var state: Observable<PRScreenState> { get }
}

enum PRScreenState {
    case loading
    case error(Error)
    case loaded(PullRequestDetails)
}

typealias PRViewModel = PRViewModelInput & PRViewModelOutput

final class PRViewModelImpl: PRViewModel {

    // MARK: - Output

    var state: Observable<PRScreenState> = Observable(.loading)

    // MARK: - Private variables

    private let useCase: PRUseCase
    private let pullRequest: PullRequest
    private let actions: PRActions
    private var lastPage: Int?
    private var currentPage = 1

    // MARK: - Lifecycle

    init(useCase: PRUseCase, pullRequest: PullRequest, actions: PRActions) {
        self.useCase = useCase
        self.pullRequest = pullRequest
        self.actions = actions
    }
}

// MARK: - Input
extension PRViewModelImpl {
    func viewDidLoad() {
        fetchPullRequest()
    }

    func refresh() {
        fetchPullRequest()
    }
}

// MARK: - Private
private extension PRViewModelImpl {
    func fetchPullRequest() {
        state.value = .loading
        useCase.fetchPR(pullRequest) { result in
            switch result {
            case .success(let prDetails):
                self.state.value = .loaded(prDetails)
            case .failure(let error):
                self.state.value = .error(error)
            }
        }
    }

//    func fetchComments() {
//        state.value = .loading
//        let request = CommentsRequestModel(item: pullRequest, page: currentPage)
//        useCase.fetchComments(request) { result in
//            switch result {
//            case .success(let response):
//                self.lastPage = response.lastPage
//                self.state.value = .loaded(self.pullRequest, response.items)
//            case .failure(let error):
//                self.state.value = .error(error)
//            }
//        }
//    }
}
