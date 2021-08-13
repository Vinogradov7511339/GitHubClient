//
//  IssuesViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

struct IssuesActions {
    let showIssue: (Issue) -> Void
}

protocol IssuesViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
}

protocol IssuesViewModelOutput {
    var issues: Observable<[Issue]> { get }
}

typealias IssuesViewModel = IssuesViewModelInput & IssuesViewModelOutput

final class IssuesViewModelImpl: IssuesViewModel {

    // MARK: - Output
    var issues: Observable<[Issue]> = Observable([])

    // MARK: - Private
    private let useCase: IssuesUseCase
    private let issuesType: IssuesType
    private let actions: IssuesActions
    private var lastPage: Int?

    init(useCase: IssuesUseCase, issuesType: IssuesType, actions: IssuesActions) {
        self.useCase = useCase
        self.issuesType = issuesType
        self.actions = actions
    }
}

// MARK: - Input
extension IssuesViewModelImpl {
    func viewDidLoad() {
        let page = 1
        let request = IssuesRequestModel(page: page, issuesType: issuesType)
        useCase.fetch(request: request) { result in
            switch result {
            case .success(let model):
                self.lastPage = model.lastPage
                self.issues.value.append(contentsOf: model.items)
            case .failure(let error):
                print(error)
            }
        }
    }

    func didSelectItem(at indexPath: IndexPath) {
        actions.showIssue(issues.value[indexPath.row])
    }
}
