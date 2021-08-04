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
}

protocol StarredViewModelOutput {
    
}

typealias StarredViewModel = StarredViewModelInput & StarredViewModelOutput

final class StarredViewModelImpl: StarredViewModel {

    private let starredUseCase: StarredUseCase
    private let actions: StarredActions

    // MARK: - Init

    init(starredUseCase: StarredUseCase, actions: StarredActions) {
        self.starredUseCase = starredUseCase
        self.actions = actions
    }
}

// MARK: - StarredViewModelInput
extension StarredViewModelImpl {
    func viewDidLoad() {
        starredUseCase.fetch(page: 0) { result in
            switch result {
            case .success(let repositories):
                print("repositories \(repositories)")
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
}
