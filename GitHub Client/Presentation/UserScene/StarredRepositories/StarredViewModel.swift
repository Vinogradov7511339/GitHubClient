//
//  StarredViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

struct StarredActions {
    let showDetails: (Repository) -> Void
}

protocol StarredViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
}

protocol StarredViewModelOutput {
    var items: Observable<[Repository]> { get }
    var error: Observable<String> { get }
}

typealias StarredViewModel = StarredViewModelInput & StarredViewModelOutput

final class StarredViewModelImpl: StarredViewModel {

    private let starredUseCase: StarredUseCase
    private let actions: StarredActions

    private var currentPage = 0

    // MARK: - Output

    var items: Observable<[Repository]> = Observable([])
    var error: Observable<String> = Observable("")

    // MARK: - Init

    init(starredUseCase: StarredUseCase, actions: StarredActions) {
        self.starredUseCase = starredUseCase
        self.actions = actions
    }
}

// MARK: - StarredViewModelInput
extension StarredViewModelImpl {
    func viewDidLoad() {
        starredUseCase.fetch(page: currentPage) { result in
            switch result {
            case .success(let repositories):
                self.appendResults(repositories)
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let item = self.items.value[indexPath.row]
        actions.showDetails(item)
    }
}

// MARK: - Private
private extension StarredViewModelImpl {
    func appendResults(_ results: [Repository]) {
        self.items.value.append(contentsOf: results)
    }
    
    func handleError(_ error: Error) {
        let errorTempName = NSLocalizedString("TempError", comment: "")
        self.error.value = errorTempName
    }
}
