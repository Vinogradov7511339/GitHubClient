//
//  ReleasesViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import UIKit

struct ReleasesActions {
    let show: (Release) -> Void
}

protocol ReleasesViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
}

protocol ReleasesViewModelOutput {
    var releases: Observable<[Release]> { get }
}

typealias ReleasesViewModel = ReleasesViewModelInput & ReleasesViewModelOutput

final class ReleasesViewModelImpl: ReleasesViewModel {

    // MARK: - Output

    var releases: Observable<[Release]> = Observable([])

    // MARK: - Private variables

    // MARK: - Lifecycle

    init() {}
}

// MARK: - Input
extension ReleasesViewModelImpl {
    func viewDidLoad() {}

    func didSelectItem(at indexPath: IndexPath) {}
}

// MARK: - Private
private extension ReleasesViewModelImpl {}
