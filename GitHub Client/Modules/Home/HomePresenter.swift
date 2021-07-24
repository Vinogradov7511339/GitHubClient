//
//  HomePresenter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit

protocol HomePresenterInput {
    var output: HomePresenterOutput? { get set }
    
    func viewDidLoad()
    func refresh()
    
    func didSelectItem(at indexPath: IndexPath)
    
    func header(for section: Int) -> UIView
    func heightForHeader(in section: Int) -> CGFloat
    func heightForCell(at indexPath: IndexPath) -> CGFloat
}


protocol HomePresenterOutput: AnyObject {
    func display(viewModels: [[Any]])
    
    func push(to viewController: UIViewController)
}

class HomePresenter {
    var interactor: HomeInteractorInput!
    weak var output: HomePresenterOutput?
    
    private var profile: UserProfile?
    private var issues: [Issue] = []
}

//MARK: - MyWorkInteractorOutput
extension HomePresenter: HomeInteractorOutput {
    func didReceive(allIssues: [Issue]) {
        self.issues = allIssues
        DispatchQueue.main.async {
            self.fullViewModels()
        }
    }
    
    func didReceive(error: Error) {
        //todo
    }
}

//MARK: - MyWorkPresenterInput
extension HomePresenter: HomePresenterInput {
    func viewDidLoad() {
        interactor.fetchAllIssues()
    }
    
    func refresh() {
        interactor.fetchAllIssues()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let viewController = IssuesListConfigurator.createModule(from: issues)
            output?.push(to: viewController)
        case (0, 3):
            let viewController = RepositoriesListConfigurator.createModule()
            output?.push(to: viewController)
        default:
            break
        }
        
    }
    
    func header(for section: Int) -> UIView {
        let view = UIView()
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 0, y: 12, width: 320, height: 20)
        myLabel.font = UIFont.boldSystemFont(ofSize: 22)
        switch section {
        case 0:
            myLabel.text = "My Work"
        case 1:
            myLabel.text = "Favorites"
        case 2:
            myLabel.text = "Recent"
        default:
            break
        }
        
        view.addSubview(myLabel)
        return view
    }
    
    func heightForHeader(in section: Int) -> CGFloat {
        switch section {
        case 0:
            return 50.0
        case 1:
            return 60.0
        default:
            return 60.0
        }
    }
    
    func heightForCell(at indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 56.0
        case 2:
            return 80.0
        default:
            return UITableView.automaticDimension
        }
    }
}
// MARK: - fill viewModels
private extension HomePresenter {
    func fullViewModels() {
        let firstSection = firstSectionViewModels()
        let favoritesSetion = favoritesSectionViewModels()
        let recentSection = recentSectionViewModels()
        output?.display(viewModels: [firstSection, favoritesSetion, recentSection])
    }
    
    func firstSectionViewModels() -> [TableCellViewModel] {
        var models: [TableCellViewModel] = []
        
        let issuesViewModel = TableCellViewModel(text: "Issues", detailText: nil, image: UIImage.issue, imageTintColor: .systemGreen, accessoryType: .disclosureIndicator)
        models.append(issuesViewModel)
        
        let pullRequestsViewModel = TableCellViewModel(text: "Pull Requests", detailText: nil, image: UIImage.pullRequest, imageTintColor: .systemBlue, accessoryType: .disclosureIndicator)
        models.append(pullRequestsViewModel)
        
        let discussionsViewModel = TableCellViewModel(text: "Discussions", detailText: nil, image: UIImage(systemName: "message"), imageTintColor: .systemPurple, accessoryType: .disclosureIndicator)
        models.append(discussionsViewModel)
        
        let repositoriesViewModel = TableCellViewModel(text: "Repositories", detailText: nil, image: UIImage(systemName: "book.closed.fill"), imageTintColor: .systemGray, accessoryType: .disclosureIndicator)
        models.append(repositoriesViewModel)
        
        let organizationsViewModel = TableCellViewModel(text: "Organizations", detailText: nil, image: UIImage(systemName: "building.2.fill"), imageTintColor: .systemOrange, accessoryType: .disclosureIndicator)
        models.append(organizationsViewModel)
        
        return models
    }
    
    func favoritesSectionViewModels() -> [Any] {
        let emptyViewModel = FavoritesEmptyCellViewModel()
        return [emptyViewModel]
        
    }
    
    func recentSectionViewModels() -> [Any] {
        return issues.map { RecentEventsCellViewModel(issue: $0) }
    }
}
