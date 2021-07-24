//
//  IssuesPresenter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit

protocol IssuesPresenterInput {
    var output: IssuesPresenterOutput? { get set }
    
    func viewDidLoad()
    func refresh()
    
    func openIssue(at indexPath: IndexPath)
}

protocol IssuesPresenterOutput: AnyObject {
    func display(viewModels: [Any])
    
    func push(to viewController: UIViewController)
}

class IssuesPresenter {
    weak var output: IssuesPresenterOutput?
    
    private let issuesService = ServicesManager.shared.issuesService
    private var issues: [Issue] = []
    
    init(with issues: [Issue]) {
        self.issues = issues
    }
}

// MARK: - IssuesPresenterInput
extension IssuesPresenter: IssuesPresenterInput {
    func viewDidLoad() {
        let viewModels = issues.compactMap { map($0) }
        output?.display(viewModels: viewModels)
    }
    
    func refresh() {
        fetchAllIssues()
    }
    
    func openIssue(at indexPath: IndexPath) {
        let issue = issues[indexPath.row]
        let viewController = IssueDetailsConfigurator.createModule(for: issue)
        output?.push(to: viewController)
    }
}

// MARK: - IssuesPresenterInput
private extension IssuesPresenter {
    func fetchAllIssues() {
        issuesService.getAllIssues { [weak self] issues, error in
            if let issues = issues {
                self?.issues = issues
                let viewModels = issues.compactMap { self?.map($0) }
                DispatchQueue.main.async {
                    self?.output?.display(viewModels: viewModels)
                }
                return
            }
            if let error = error {
                print(error)
            }
        }
    }
}

// MARK: - private
private extension IssuesPresenter {
    func map(_ issue: Issue) -> IssueCellViewModel {
        let repositoryName = issue.repository?.full_name ?? ""
        let name = issue.title ?? ""
        let date = "NaN"
        return IssueCellViewModel(
            image: UIImage.issue,
            repositoryName: repositoryName,
            name: name,
            date: date,
            bottomImage: nil
        )
    }
}
