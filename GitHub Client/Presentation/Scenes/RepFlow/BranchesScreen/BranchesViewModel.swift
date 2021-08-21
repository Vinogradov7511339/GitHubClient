//
//  BranchesViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.08.2021.
//

import UIKit

struct BranchesActions {
    let select: (Branch) -> Void
}

protocol BranchesViewModelInput {
    func viewDidLoad()
    func didSelectRow(at indexPath: IndexPath)
}

protocol BranchesViewModelOutput {
    var branches: Observable<[Branch]> { get }
}

typealias BranchesViewModel = BranchesViewModelInput & BranchesViewModelOutput

final class BranchesViewModelImpl: BranchesViewModel {

    // MARK: - Output

    var branches: Observable<[Branch]> = Observable([])

    // MARK: - Private variables

    private let actions: BranchesActions
    private let repUserCase: RepUseCase
    private let repository: Repository
    private var currentPage = 1
    private var lastPage: Int?

    // MARK: - Lifcycle

    init(actions: BranchesActions, repUserCase: RepUseCase, repository: Repository) {
        self.actions = actions
        self.repUserCase = repUserCase
        self.repository = repository
    }
}

// MARK: - Input
extension BranchesViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func didSelectRow(at indexPath: IndexPath) {
        let selectedBranch = branches.value[indexPath.row]
        actions.select(selectedBranch)
    }
}

// MARK: - Private
private extension BranchesViewModelImpl {
    func fetch() {
        let model = BranchesRequestModel(repository: repository, page: currentPage)
        repUserCase.fetchBranches(request: model) { result in
            switch result {
            case .success(let response):
                self.lastPage = response.lastPage
                self.branches.value.append(contentsOf: response.branches)
            case .failure(let error):
                self.handleError(error)
            }
        }
    }

    func handleError(_ error: Error) {}
}
