//
//  IssuesPresenter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit

protocol IssuesPresenterInput: FilterViewModelListener {
    var output: IssuesPresenterOutput? { get set }
    var title: String { get }
    var shouldShowAddButton: Bool { get }
    
    func viewDidLoad()
    func refresh()
    func addFilter()
    
    func openIssue(at indexPath: IndexPath)
}

protocol IssuesPresenterOutput: AnyObject {
    func display(viewModels: [Any])
    func display(filter: IssuesFilters)
    
    func push(to viewController: UIViewController)
    func present(_ viewController: UIViewController)
}

class IssuesPresenter {
    weak var output: IssuesPresenterOutput?
    var title: String {
        switch type {
        case .myIssues, .issues(_): return "Issues"
        case .myPullRequests, .pullRequests(_): return "Pull Requests"
        case .myDiscussions, .discussions(_): return "Discussions"
        }
    }
    
    var shouldShowAddButton: Bool {
        switch type {
        case .myIssues, .myPullRequests, .myDiscussions : return true
        case .issues(_), .pullRequests(_), .discussions(_): return false
        }
    }
    
    var interactor: IssuesInteractorInput?
    
    private let issuesService = ServicesManager.shared.issuesService
    private var issues: [IssueResponseDTO] = []
    private let type: IssueType
    
    init(type: IssueType) {
        self.type = type
    }
    
    private func createFilters(from obj: IssuesFilters) {
//        let viewModels = FilterViewModel.create(from: obj)
        output?.display(filter: obj)
    }
}

extension IssuesPresenter: FilterViewModelListener {
    func filterDidUpdated(object: Any) {
        if let filter = object as? IssuesFilters {
            interactor?.updateFilter(filter: filter)
        }
    }
}

// MARK: - IssuesPresenterInput
extension IssuesPresenter: IssuesInteractorOutput {
    func didReceive(objects: [Any]) {
        if let issues = objects as? [IssueResponseDTO] {
            self.issues = issues
            DispatchQueue.main.async {
                self.output?.display(viewModels: issues)
            }
        }
    }
    
    func didReceive(filter: IssuesFilters) {
        createFilters(from: filter)
    }
    
    func didReceive(discussions: [CommentResponse]) {
        DispatchQueue.main.async {
            self.output?.display(viewModels: discussions)
        }
    }
    
    func didReceive(pullRequests: [PullRequestResponseDTO]) {
        DispatchQueue.main.async {
            self.output?.display(viewModels: pullRequests)
        }
    }
}

// MARK: - IssuesPresenterInput
extension IssuesPresenter: IssuesPresenterInput {
    func viewDidLoad() {
        interactor?.fetchFilter()
        interactor?.fetchObjects()
    }
    
    func refresh() {
        interactor?.fetchObjects()
    }
    
    func addFilter() {
        let viewController = CreateFilterViewController()
        output?.present(viewController)
    }
    
    func openIssue(at indexPath: IndexPath) {
        let issue = issues[indexPath.row]
        let viewController = IssueDetailsConfigurator.createModule(for: issue)
        output?.push(to: viewController)
    }
}
