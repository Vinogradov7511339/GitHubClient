//
//  IssuesPresenter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit

protocol IssuesPresenterInput: FilterViewModelListener {
    var output: IssuesPresenterOutput? { get set }
    var type: IssueType { get }
    
    func viewDidLoad()
    func refresh()
    func addFilter()
    
    func openIssue(at indexPath: IndexPath)
}

protocol IssuesPresenterOutput: AnyObject {
    func display(viewModels: [Any])
    func display(filter: IssueRequestParameters)
    
    func push(to viewController: UIViewController)
    func present(_ viewController: UIViewController)
}

class IssuesPresenter {
    weak var output: IssuesPresenterOutput?
    var type: IssueType
    
    var interactor: IssuesInteractorInput?
    
    private let issuesService = ServicesManager.shared.issuesService
    private var issues: [Issue] = []
    
    init(type: IssueType) {
        self.type = type
    }
    
    private func createFilters(from obj: IssueRequestParameters) {
//        let viewModels = FilterViewModel.create(from: obj)
        output?.display(filter: obj)
    }
}

extension IssuesPresenter: FilterViewModelListener {
    func filterDidUpdated(object: Any) {
        if let filter = object as? IssueRequestParameters {
            interactor?.updateFilter(filter: filter)
        }
    }
}

// MARK: - IssuesPresenterInput
extension IssuesPresenter: IssuesInteractorOutput {
    func didReceive(objects: [Any]) {
        if let issues = objects as? [Issue] {
            self.issues = issues
            DispatchQueue.main.async {
                self.output?.display(viewModels: issues)
            }
        }
    }
    
    func didReceive(filter: IssueRequestParameters) {
        createFilters(from: filter)
    }
}

//// MARK: - FilterViewDelegate
//extension IssuesPresenter: FilterViewDelegate {
//    func itemDidSelected(item: FilterViewModel) {
//
//    }
//}

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
