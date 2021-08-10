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
    var issue: Issue { get }
    var comments: Observable<[Comment]> { get }
}

typealias IssueViewModel = IssueViewModelInput & IssueViewModelOutput

final class IssueViewModelImpl: IssueViewModel {

    // MARK: - OUTPUT
    let issue: Issue
    var comments: Observable<[Comment]> = Observable([])

    // MARK: - Private
    private let useCase: IssueUseCase
    private var actions: IssueActions
    private var currentPage = 1
    private var lastPage: Int?

    init(useCase: IssueUseCase, actions: IssueActions, issue: Issue) {
        self.useCase = useCase
        self.actions = actions
        self.issue = issue
    }
}

// MARK: - Input
extension IssueViewModelImpl {
    func viewDidLoad() {
        fetchComments()
    }

    func refresh() {
        fetchComments()
    }
}

// MARK: - Private
private extension IssueViewModelImpl {
    func fetchComments() {
        let model = IssueRequestModel(issue: issue, page: currentPage)
        useCase.fetchComments(requestModel: model) { result in
            switch result {
            case .success(let model):
                self.updateComments(model)
            case .failure(let error):
                self.handle(error)
            }
        }
    }

    func updateComments(_ model: IssueResponseModel) {
        self.lastPage = model.lastPage
        self.currentPage += 1
        self.comments.value.append(contentsOf: model.comments)
    }

    func handle(_ error: Error) {}
}
