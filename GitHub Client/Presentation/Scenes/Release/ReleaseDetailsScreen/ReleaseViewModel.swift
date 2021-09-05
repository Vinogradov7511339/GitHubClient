//
//  ReleaseViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.09.2021.
//

import UIKit

struct ReleaseActions {}

protocol ReleaseViewModelInput {
    func viewDidLoad()
    func refresh()
}

protocol ReleaseViewModelOutput {
    var title: Observable<String> { get }
    var state: Observable<DetailsScreenState<Release>> { get }
}

typealias ReleaseViewModel = ReleaseViewModelInput & ReleaseViewModelOutput

final class ReleaseViewModelImpl: ReleaseViewModel {

    // MARK: - Output

    var title: Observable<String> = Observable("")
    var state: Observable<DetailsScreenState<Release>> = Observable(.loading)

    // MARK: - Private variables

    private let release: Release
    private let actions: ReleaseActions

    // MARK: - Lifecycle

    init(_ release: Release, actions: ReleaseActions) {
        self.release = release
        self.actions = actions
        title.value = "Release \(release.tagName)"
    }
}

// MARK: - Input
extension ReleaseViewModelImpl {
    func viewDidLoad() {
        state.value = .loaded(release)
    }

    func refresh() {}
}
