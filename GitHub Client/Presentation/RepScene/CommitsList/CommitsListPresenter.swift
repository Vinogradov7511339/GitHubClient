//
//  CommitsListPresenter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

protocol CommitsListPresenterInput {
    var output: CommitsListPresenterOutput? { get set }
    
    func viewDidLoad()
    func didSelectRow(at indexPath: IndexPath)
}

protocol CommitsListPresenterOutput: AnyObject {
    func display(viewModels: [Any])
    func push(to viewController: UIViewController)
}

class CommitsListPresenter {
    var output: CommitsListPresenterOutput?
    
    private let service = ServicesManager.shared.repositoryService
    private let repository: RepositoryResponse
    
    init(_ repository: RepositoryResponse) {
        self.repository = repository
    }
}

// MARK: - FavoritesPresenterInput
extension CommitsListPresenter: CommitsListPresenterInput {
    func viewDidLoad() {
        fetchCommits()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
    }
}

// MARK: - private
private extension CommitsListPresenter {
    func fetchCommits() {
        service.fetchCommits(for: repository) { commits, error in
            if let commits = commits {
                DispatchQueue.main.async {
                    let viewModels = commits.map { self.map($0) }
                    self.output?.display(viewModels: viewModels)
                }
            }
        }
    }
    
    func map(_ commit: CommitInfoResponse) -> CommitCellViewModel {
        let components = commit.commit.message.components(separatedBy: "\n\n")
        let message: String
        let additionMessage: String?
        if components.count > 1 {
            message = components[0]
            additionMessage = components[1]
        } else if components.count > 0 {
            message = components[0]
            additionMessage = nil
        } else {
            message = ""
            additionMessage = nil
        }
        
        return CommitCellViewModel(
            authorsAvatars: [commit.author.avatarUrl], //todo
            message: message,
            additionalMessage: additionMessage,
            authoredBy: NSAttributedString(string: "NaN"),
            isVerified: commit.commit.verification.verified,
            date: "NaN"
        )
    }
}
