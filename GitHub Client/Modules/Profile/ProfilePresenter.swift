//
//  ProfilePresenter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.07.2021.
//

import UIKit

protocol ProfilePresenterInput {
    var output: ProfilePresenterOutput? { get set }
    var type: ProfileType { get }
    
    func viewDidLoad()
    func refresh()
    
    func didSelectItem(at indexPath: IndexPath)
    func openFollowing()
    func openFollowers()
    func openLink()
    func openSendMail()
    
    func share()
}

protocol ProfilePresenterOutput: AnyObject {
    
    func display(viewModels: [[Any]])
    func showError(error: Error)
    
    func push(to viewController: UIViewController)
}

class ProfilePresenter {
    
    weak var output: ProfilePresenterOutput?
    
    var interactor: ProfileInteractorInput!
    var type: ProfileType
    
    private var profileInfo: ProfileInfo?
    
    init(type: ProfileType) {
        self.type = type
    }

    private func fullViewModels(with profileInfo: ProfileInfo) {
        let mostPopularViewModel = ProfileMostPopularCellViewModel(repositories: profileInfo.popularRepos)
        
        let repositories = TableCellViewModel(
            text: "Repositories",
            detailText: "\(profileInfo.userProfile.publicRepos ?? 0)",
            image: UIImage(systemName: "book.closed.fill"), imageTintColor: .systemPurple,
            accessoryType: .disclosureIndicator)
        let stared = TableCellViewModel(
            text: "Starred",
            detailText: "\(profileInfo.starredReposCount)",
            image: UIImage(systemName: "star.square"), imageTintColor: .systemYellow,
            accessoryType: .disclosureIndicator)
        let organizations = TableCellViewModel(
            text: "Organizations",
            detailText: "\(-1)",
            image: UIImage(systemName: "building.2.fill"), imageTintColor: .systemOrange,
            accessoryType: .disclosureIndicator)
        let items = [repositories, stared, organizations]
        
        output?.display(viewModels: [[profileInfo.userProfile], [mostPopularViewModel], items])
    }
}

// MARK: - ProfileInteractorOutput
extension ProfilePresenter: ProfileInteractorOutput {
    func didReceive(profileInfo: ProfileInfo) {
        self.profileInfo = profileInfo
        fullViewModels(with: profileInfo)
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
        guard let profile = profileInfo?.userProfile else { return }
        let viewController = RepositoriesListConfigurator.createModule(with: .iHasAccessTo(profile: profile))
        output?.push(to: viewController)
    }
    
    func openStarred() {
        guard let profile = profileInfo?.userProfile else { return }
        let viewController = RepositoriesListConfigurator.createModule(with: .starred(profile: profile))
        output?.push(to: viewController)
    }
    
    func openOrganizations() {
    }
    
    func viewDidLoad() {
        interactor.fetchProfile()
    }
    
    func refresh() {
        interactor.fetchProfile()
    }
    
    func openFollowing() {
        guard let profile = profileInfo?.userProfile else { return }
        let viewController = UsersListConfigurator.createModule(profile: profile, type: .following)
        output?.push(to: viewController)
    }
    
    func openFollowers() {
        guard let profile = profileInfo?.userProfile else { return }
        let viewController = UsersListConfigurator.createModule(profile: profile, type: .followers)
        output?.push(to: viewController)
    }
    
    func openLink() {
    }
    
    func openSendMail() {
    }
    
    func share() {
    }
}
