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
}

// MARK: - Private
private extension BranchesViewModelImpl {
    func fetch() {
        repUserCase.fetchBranches(repository: repository) { result in
            switch result {
            case .success(let branches):
                self.branches.value = branches
            case .failure(let error):
                self.handleError(error)
            }
        }
    }

    func handleError(_ error: Error) {}
}
