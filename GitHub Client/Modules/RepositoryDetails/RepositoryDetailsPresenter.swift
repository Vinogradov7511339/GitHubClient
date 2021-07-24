//
//  RepositoryDetailsPresenter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.07.2021.
//

import UIKit

protocol RepositoryPresenterInput {
    var output: RepositoryPresenterOutput? { get set }
    func viewDidLoad()
}

protocol RepositoryPresenterOutput: AnyObject {
    func display(viewModels: [[Any]])
}

class RepositoryPreseter {
    weak var output: RepositoryPresenterOutput?
    
    let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    private func getModels() -> [[Any]] {
        var header = [headerViewModel(repository)]
        header.append(contentsOf: firstSection(repository))
        let secondBlock = secondSection(repository)
        let readMe = readMeViewModel(repository)
        let models = [header, secondBlock, [readMe]]
        return models
    }
    
    private func headerViewModel(_ repository: Repository) -> Any {
        return RepositoryDetailsHeaderCellViewModel(repository: repository)
    }
    
    private func firstSection(_ repository: Repository) -> [Any] {
        var models: [TableCellViewModel] = []
        
        if repository.has_issues ?? false {
            let issuesViewModel = TableCellViewModel(text: "Issues", detailText: "\(repository.open_issues_count ?? -1)", image: UIImage.issue, imageTintColor: .systemGreen, accessoryType: .disclosureIndicator)
            models.append(issuesViewModel)
        }
        
        let pullRequests = TableCellViewModel(text: "Pull Requests", detailText: "\(-1)", image: UIImage.pullRequest, imageTintColor: .systemBlue, accessoryType: .disclosureIndicator)
        models.append(pullRequests)
        
        let releases = TableCellViewModel(text: "Releases", detailText: "\(-1)", image: UIImage.releases, imageTintColor: .systemGray, accessoryType: .disclosureIndicator)
        models.append(releases)
        
        let discussions = TableCellViewModel(text: "Discussions", detailText: "\(-1)", image: UIImage.discussions, imageTintColor: .systemPurple, accessoryType: .disclosureIndicator)
        models.append(discussions)
        
        let watchers = TableCellViewModel(text: "Watchers", detailText: "\(repository.watchers_count ?? -1)", image: UIImage.watchers, imageTintColor: .systemYellow, accessoryType: .disclosureIndicator)
        models.append(watchers)
        
        let license = TableCellViewModel(text: "License", detailText: "\(repository.license?.name ?? "NaN")", image: UIImage.license, imageTintColor: .systemRed, accessoryType: .disclosureIndicator)
        models.append(license)
        
        return models
    }
    
    private func secondSection(_ repository: Repository) -> [Any] {
        var models: [TableCellViewModel] = []
        
        let code = TableCellViewModel(text: "Browse code", detailText: nil, image: nil, imageTintColor: nil, accessoryType: .disclosureIndicator)
        models.append(code)
        
        let commits = TableCellViewModel(text: "Commits", detailText: "\(-1)", image: nil, imageTintColor: nil, accessoryType: .disclosureIndicator)
        models.append(commits)
        
        return models
    }
    
    private func readMeViewModel(_ repository: Repository) -> Any {
        return ReadMeCellViewModel()
    }
    
}

extension RepositoryPreseter: RepositoryPresenterInput {
    func viewDidLoad() {
        output?.display(viewModels: getModels())
    }
}
