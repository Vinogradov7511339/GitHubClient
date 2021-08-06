//
//  HomeViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import UIKit

struct HomeActions {
    let showIssues: () -> Void
    let showPullRequests: () -> Void
    let showDiscussions: () -> Void
    let showOrganizations: () -> Void
    let showFavorites: () -> Void
    let showRepository: (Repository) -> Void
    let showRecentEvent: (Issue) -> Void
}

protocol HomeViewModelInput {
    func viewDidLoad()
}

protocol HomeViewModelOutput {
}

typealias HomeViewModel = HomeViewModelInput & HomeViewModelOutput

final class HomeViewModelImpl: HomeViewModel {
}

extension HomeViewModelImpl {
    func viewDidLoad() {
    }
}
