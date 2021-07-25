//
//  ProfilePresenter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.07.2021.
//

import UIKit

protocol ProfilePresenterInput {
    var output: ProfilePresenterOutput? { get set }
    
    func viewDidLoad()
    func refresh()
    
    func didSelectItem(at indexPath: IndexPath)
}

protocol ProfilePresenterOutput: AnyObject {
    
    func display(viewModels: [[Any]])
    func showError(error: Error)
    
    func push(to viewController: UIViewController)
}

class ProfilePresenter {
    
    weak var output: ProfilePresenterOutput?
    var interactor: ProfileInteractorInput!

    private var popularRepositories: [Repository] = []
    private var starredRepositories: [Repository] = []
    private var allMyRepositories: [Repository] = []
    private var profile: UserProfile?
    
    
    private func fullViewModels() {
        guard let profile = self.profile else { return }
        let profileViewModel = ProfileHeaderCellViewModel(profile)
        let mostPopularViewModel = ProfileMostPopularCellViewModel(repositories: popularRepositories)
        
        let repositories = TableCellViewModel(
            text: "Repositories",
            detailText: "\(allMyRepositories.count)",
            image: UIImage(systemName: "book.closed.fill"), imageTintColor: .systemPurple,
            accessoryType: .disclosureIndicator)
        let stared = TableCellViewModel(
            text: "Starred",
            detailText: "\(starredRepositories.count)",
            image: UIImage(systemName: "star.square"), imageTintColor: .systemYellow,
            accessoryType: .disclosureIndicator)
        let organizations = TableCellViewModel(
            text: "Organizations",
            detailText: "\(-1)",
            image: UIImage(systemName: "building.2.fill"), imageTintColor: .systemOrange,
            accessoryType: .disclosureIndicator)
        let items = [repositories, stared, organizations]
        
        output?.display(viewModels: [[profileViewModel], [mostPopularViewModel], items])
    }
}

// MARK: - ProfileInteractorOutput
extension ProfilePresenter: ProfileInteractorOutput {
    func didReceive(allMyRepositories: [Repository]) {
        self.allMyRepositories = allMyRepositories
        DispatchQueue.main.async {
            self.fullViewModels()
        }
    }
    
    func didReceive(starredRepositories: [Repository]) {
        self.starredRepositories = starredRepositories
        interactor.fetchMyAllRepositories()
    }
    
    func didReceive(popularRepositories: [Repository]) {
        self.popularRepositories = popularRepositories
        interactor.fetchStarredRepositories()
    }
    
    func didReceive(profile: UserProfile) {
        self.profile = profile
        interactor.fetchMyPopularRepositories()
    }
    
    func didReceive(error: Error) {
    }
}


// MARK: - ProfilePresenterInput
extension ProfilePresenter: ProfilePresenterInput {
    func didSelectItem(at indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            openRepositories()
        case 1:
            openStarred()
        case 2:
            openOrganizations()
        default:
            break
        }
    }
    func openRepositories() {
        let viewController = RepositoriesListConfigurator.createModule(with: .iHasAccessTo(repositories: allMyRepositories))
        output?.push(to: viewController)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            viewController.viewModels = self.popularRepositories
//        }
    }
    
    func openRepository(repository: Repository) {
        let viewController = RepositoryDetailsConfigurator.createModule(for: repository)
        output?.push(to: viewController)
    }
    
    func openStarred() {
        let viewController = RepositoriesListConfigurator.createModule(with: .starred(repositories: starredRepositories))
        output?.push(to: viewController)
    }
    
    func openOrganizations() {
    }
    
    func viewDidLoad() {
        interactor.fetchMyProfile()
    }
    
    func refresh() {
        interactor.fetchMyProfile()
    }
}
