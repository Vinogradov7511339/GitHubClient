//
//  IssueViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import UIKit

protocol IssueViewModelInput {
    func viewDidLoad()
    func refresh()
}

protocol IssueViewModelOutput {
    var issue: Issue { get }
    var items: Observable<[[Any]]> { get }
}

typealias IssueViewModel = IssueViewModelInput & IssueViewModelOutput

final class IssueViewModelImpl: IssueViewModel {

    // MARK: - OUTPUT
    let issue: Issue
    var items: Observable<[[Any]]> = Observable([[]])

    init(issue: Issue) {
        self.issue = issue
    }
}

// MARK: - Input
extension IssueViewModelImpl {
    func viewDidLoad() {
    }

    func refresh() {
    }
}
