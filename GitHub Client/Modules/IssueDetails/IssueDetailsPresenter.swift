//
//  IssueDetailsPresenter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit
import TextCompiler

protocol IssueDetailsPresenterInput {
    var output: IssueDetailsPresenterOutput? { get set }
    
    func viewDidLoad()
    func refresh()
}

protocol IssueDetailsPresenterOutput: AnyObject {
    func display(viewModels: [[Any]])
    
    func push(to viewController: UIViewController)
}

class IssueDetailsPresenter {
    
    weak var output: IssueDetailsPresenterOutput?
    
    private let issuesService = ServicesManager.shared.issuesService
//    private let render = MarkdownRenderer(baseFont: UIFont.systemFont(ofSize: 18.0))
    private var issue: Issue
    
    init(_ issue: Issue) {
        self.issue = issue
    }
}

// MARK: - IssueDetailsPresenterInput
extension IssueDetailsPresenter: IssueDetailsPresenterInput {
    func viewDidLoad() {
        fillViewModel()
    }
    
    func refresh() {
        fetchIssue()
    }
}

private extension IssueDetailsPresenter {
    
    func fetchIssue() {
        guard let url = issue.url else { return }
        issuesService.fetchIssue(url: url) { [weak self] issue, error in
            if let issue = issue {
                self?.issue = issue
                DispatchQueue.main.async {
                    self?.fillViewModel()
                }
                return
            }
        }
    }
    func fillViewModel() {
        let viewModels = [[getHeader()], [getBody()]]
        output?.display(viewModels: viewModels)
    }
    
    func getHeader() -> IssueHeaderCellViewModel {
        let avatarUrl = issue.user?.avatar_url
        let repositoryName = issue.repository?.full_name ?? ""
        let title = issue.title ?? ""
        return IssueHeaderCellViewModel(
            avatarUrl: avatarUrl,
            repositoryName: repositoryName,
            title: title,
            stateImage: nil
        )
    }
    
    func getBody() -> IssueCommentCellViewModel {
        let avatarUrl = issue.user?.avatar_url
        let userName = issue.user?.login ?? ""
        let status = issue.author_association ?? ""
        
      
        
        return IssueCommentCellViewModel(
            avatarUrl: avatarUrl,
            userName: userName,
            userStatus: status,
            message: issue.body ?? "",
            reactImages: []
        )
    }
    
    
}

extension String {
    func parse() -> NSAttributedString {
        let nsString = NSString(string: self)
        let mutableString = NSMutableAttributedString(string: self)

        let headerRange = nsString.findHeaders()
        mutableString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 18.0), range: headerRange)

        let boldRange = nsString.findBoldText()
        mutableString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16.0), range: boldRange)

        let italicRange = nsString.findItalic()
        mutableString.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: 16.0), range: italicRange)

        return mutableString
    }

}

extension NSString {
    func findHeaders() -> NSRange {
        let pattern = "\\###.*\\\r\n"
        return self.range(of: pattern, options: .regularExpression)
    }

    func findBoldText() -> NSRange {
        let pattern = "\\**.*\\**"
        return self.range(of: pattern, options: .regularExpression)
    }

    func findItalic() -> NSRange {
        let pattern = "\\_.*\\_"
        return self.range(of: pattern, options: .regularExpression)
    }
}
