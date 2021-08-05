//
//  ExploreCollectionViewLayout.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

protocol ExplorePresenterOutput: AnyObject {
    func reloadData()
    func push(to viewController: UIViewController)
}

protocol ExplorePresenterInput {
    var output: ExplorePresenterOutput? { get set }
    
    var layout: UICollectionViewLayout { get }
    var dataViewMap: [String: CollectionCellManager] { get }
    
    func viewDidLoad()
}

class ExplorePresenter: NSObject {
    
    enum SectionType: Int, CaseIterable {
        case singleList     // Featured
        case doubleList     // This weeks favorites
        case tripleList     // Learn something
        case categoryList   // Top Categories
    }
    
    struct Section {
        let type: SectionType
        let data: [Any]
    }
    
    var layout: UICollectionViewLayout {
        return create()
    }
    
    weak var output: ExplorePresenterOutput?
    
    private var dataSource: [Section] = []
    
    var dataViewMap: [String: CollectionCellManager] = [
        "\(FeaturedCellViewModel.self)": CollectionCellManager.create(cellType: FeaturedCollectionViewCell.self),
        "\(MediumCellViewModel.self)": CollectionCellManager.create(cellType: MediumCollectionViewCell.self),
        "\(SmallCellViewModel.self)": CollectionCellManager.create(cellType: SmallCollectionViewCell.self),
        "\(SmallCategoryCellViewModel.self)":
            CollectionCellManager.create(cellType: SmallCategoryCollectionViewCell.self)
    ]
    
    private let service = ServicesManager.shared.repositoryService
    private var repositories: [RepositoryResponse] = []
}

// MARK: - layout
private extension ExplorePresenter {
    func create() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            switch self.sectionType(for: section) {
            case .singleList: return self.createSingleListSection()
            case .doubleList: return self.createDoubleListSection()
            case .tripleList: return self.createTripleListSection()
            case .categoryList: return self.createCategoryListSection(for: self.numberOfItems(in: section))
            }
        }
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20.0
        layout.configuration = configuration
        
        return layout
    }
    
    func createSingleListSection() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .estimated(320))
        
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: layoutGroup)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        return section
    }
    
    func createDoubleListSection() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.95),
            heightDimension: .estimated(180.0)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(8.0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let header = createHeader()
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    func createTripleListSection() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.33)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.95),
            heightDimension: .estimated(165.0)
        )
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
        group.interItemSpacing = .fixed(8.0)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let header = createHeader()
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    func createCategoryListSection(for itemsCount: Int) -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(CGFloat(1 / itemsCount))
        )
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 5)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.95),
            heightDimension: .estimated(CGFloat( Double(itemsCount) * 40.0))
        )
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: itemsCount)
        group.interItemSpacing = .fixed(8.0)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let header = createHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
}

// MARK: - UICollectionViewDataSource
extension ExplorePresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = dataSource[indexPath.section].data[indexPath.row]
        guard let manager = cellManager(for: viewModel) else {
            assert(false, "unknown viewModel \(viewModel) at \(indexPath)")
            return UICollectionViewCell(frame: .zero)
        }
        let cell = manager.dequeueReusableCell(collectionView: collectionView, for: indexPath)
        cell.populate(viewModel: viewModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems(in: section)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }

    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .estimated(80.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: size,
            elementKind: UICollectionView.elementKindSectionHeader, alignment: .top
        )
        return header
    }
}

// MARK: - ExplorePresenterInput
extension ExplorePresenter: ExplorePresenterInput {
    func viewDidLoad() {
        service.mostPopularRepositories { [weak self] result, error in
            if let repositories = result?.items {
                self?.repositories = repositories
                DispatchQueue.main.async {
                    self?.mapRepositories(repositories: repositories)
                }
            }
            if let error = error {
                print("error \(error)")
            }
        }
    }
}

// MARK: - private
private extension ExplorePresenter {
    func mapRepositories(repositories: [RepositoryResponse]) {
        var firstSectionData: [Any] = []
        var secondSectionData: [Any] = []
        var thirdSectionData: [Any] = []
        var fourthSectionData: [Any] = []

        for (index, repository) in repositories.enumerated() {
            if Double(index) < Double(repositories.count) * 0.25 {
                firstSectionData.append(FeaturedCellViewModel(repository: repository))
            } else if Double(index) < Double(repositories.count) * 0.5 {
                secondSectionData.append(MediumCellViewModel(repository: repository))
            } else if Double(index) < Double(repositories.count) * 0.75 {
                thirdSectionData.append(SmallCellViewModel(repository: repository))
            } else {
                if let profile = repository.owner {
                    fourthSectionData.append(SmallCategoryCellViewModel(profile: profile))
                }
            }
        }

        let firstSection = Section(type: .singleList, data: firstSectionData)
        let secondSection = Section(type: .doubleList, data: secondSectionData)
        let thirdSection = Section(type: .tripleList, data: thirdSectionData)
        let fourthSection = Section(type: .categoryList, data: fourthSectionData)

        dataSource = [firstSection, secondSection, thirdSection, fourthSection]
        output?.reloadData()
    }

    func sectionType(for section: Int) -> SectionType {
        let section = dataSource[section]
        return section.type
    }

    func numberOfItems(in section: Int) -> Int {
        dataSource[section].data.count
    }

    func cellManager(for viewModel: Any) -> CollectionCellManager? {
        let key = "\(type(of: viewModel))"
        let cellManager = dataViewMap[key]
        return cellManager
    }
}
