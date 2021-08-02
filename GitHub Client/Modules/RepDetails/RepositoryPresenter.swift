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
    var interactor: RepositoryInteractorInput!
    var repositoryInfo: RepositoryInfo?
    
    let repository: RepositoryResponse
    
    init(repository: RepositoryResponse) {
        self.repository = repository
    }
    
    private func getModels() -> [[Any]] {
        guard let repositoryInfo = repositoryInfo else { return [] }
        var header = [headerViewModel(repository)]
        header.append(contentsOf: firstSection(repositoryInfo))
        let secondBlock = secondSection(repositoryInfo)
        let readMe = readMeViewModel(for: repositoryInfo.readMe)
        let models = [header, secondBlock, [readMe]]
        return models
    }
    
    private func headerViewModel(_ repository: RepositoryResponse) -> Any {
        return RepositoryDetailsHeaderCellViewModel(repository: repository)
    }
    
    private func firstSection(_ repositoryInfo: RepositoryInfo) -> [Any] {
        let strategy = RepositoryCellsStrategy(repositoryInfo: repositoryInfo)
        return strategy.viewModels()
    }

    private func secondSection(_ repositoryInfo: RepositoryInfo) -> [Any] {
        var models: [TableCellViewModel] = []

        let code = TableCellViewModel(
            text: "Browse code",
            detailText: nil,
            image: nil,
            imageTintColor: nil,
            accessoryType: .disclosureIndicator)
        models.append(code)
        
        let commits = TableCellViewModel(
            text: "Commits",
            detailText: "\(repositoryInfo.commitsCount)",
            image: nil,
            imageTintColor: nil,
            accessoryType: .disclosureIndicator)
        models.append(commits)
        
        return models
    }

    private func readMeViewModel(for text: String) -> Any {
        return ReadMeCellViewModel(mdText: text)
    }
}

// MARK: - RepositoryDetailsInteractorOutput
extension RepositoryPreseter: RepositoryInteractorOutput {
    func didReceive(repositoryInfo: RepositoryInfo) {
        self.repositoryInfo = repositoryInfo
        DispatchQueue.main.async {
            self.output?.display(viewModels: self.getModels())
        }
    }
}

extension RepositoryPreseter: RepositoryPresenterInput {
    func viewDidLoad() {
        interactor.fetchRepositoryInfo()
    }
}
