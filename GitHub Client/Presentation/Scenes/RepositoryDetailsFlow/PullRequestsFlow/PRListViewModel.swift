//
//  PRListViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import UIKit

struct PRListActions {
    let show: (PullRequest) -> Void
}

protocol PRListViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
}

protocol PRListViewModelOutput {
    var items: Observable<[PullRequest]> { get }
}

typealias PRListViewModel = PRListViewModelInput & PRListViewModelOutput

final class PRListViewModelImpl: PRListViewModel {

    // MARK: - Output

    var items: Observable<[PullRequest]> = Observable([])

    // MARK: - Private variables

    // MARK: - Lifecycle
}

// MARK: - Input
extension PRListViewModelImpl {
    func viewDidLoad() {}

    func didSelectItem(at indexPath: IndexPath) {}
}

// MARK: - Private
private extension PRListViewModelImpl {

}
