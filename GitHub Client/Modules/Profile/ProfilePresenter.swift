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
    
    func openRepository()
    func openRepositories()
    func openStarred()
    func openOrganizations()
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
    private var profile: UserProfile?
    
    
    private func fullViewModels() {
        guard let profile = self.profile else { return }
        let profileViewModel = ProfileHeaderCellViewModel(profile)
        let mostPopularViewModel = ProfileMostPopularCellViewModel(repositories: popularRepositories)
        
        let repositories = TableCellViewModel(
            text: "Repositories",
            detailText: "\((profile.public_repos ?? 0) + (profile.total_private_repos ?? 0))",
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
    func didReceive(starredRepositories: [Repository]) {
        self.starredRepositories = starredRepositories
        DispatchQueue.main.async {
            self.fullViewModels()
        }
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
    func openRepositories() {
        let viewController = MyRepositoriesViewController()
        output?.push(to: viewController)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            viewController.viewModels = self.popularRepositories
        }
    }
    
    func openRepository() {
        let repository = popularRepositories.last!
        let viewController = RepositoryDetailsConfigurator.createModule(for: repository)
        output?.push(to: viewController)
    }
    
    func openStarred() {
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
