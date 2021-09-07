//
//  IssueViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import UIKit

struct IssueActions {}

protocol IssueViewModelInput {
    func viewDidLoad()
    func refresh()
}

protocol IssueViewModelOutput {
    var state: Observable<IssueScreenState> { get }
}

enum IssueScreenState {
    case loading
    case error(Error)
    case loaded(Issue, [Comment])
}

typealias IssueViewModel = IssueViewModelInput & IssueViewModelOutput

final class IssueViewModelImpl: IssueViewModel {

    // MARK: - OUTPUT

    var state: Observable<IssueScreenState> = Observable(.loading)

    // MARK: - Private variables

    private let url: URL
    private let useCase: IssueUseCase
    private var actions: IssueActions
    private var currentPage = 1
    private var lastPage: Int?

    // MARK: - Lifecycle

    init(_ url: URL, useCase: IssueUseCase, actions: IssueActions) {
        self.url = url
        self.useCase = useCase
        self.actions = actions
    }
}

// MARK: - Input
extension IssueViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func refresh() {
        fetch()
    }
}

// MARK: - Private
private extension IssueViewModelImpl {
    func fetch() {
        state.value = .loading
        useCase.fetchIssue(url) { result in
            switch result {
            case .success(let issue):
                self.state.value = .loaded(issue, [])
            case .failure(let error):
                self.state.value = .error(error)
            }
        }
    }
    func fetchComments() {
//        let model = CommentsRequestModel<Issue>(item: issue, page: currentPage)
//        useCase.fetchComments(model) { result in
//            switch result {
//            case .success(let model):
//                self.updateComments(model)
//            case .failure(let error):
//                self.handle(error)
//            }
//        }
    }
}
