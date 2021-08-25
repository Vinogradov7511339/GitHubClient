//
//  ExploreLayout.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

class ExploreLayout {

    enum SectionType: Int, CaseIterable {
        case popular
    }

    lazy var layout: UICollectionViewCompositionalLayout = {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            let type = SectionType(rawValue: section) ?? .popular
            switch type {
            case .popular: return self.widgetsSection
            }
        }

        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20.0
        layout.configuration = configuration

        return layout
    }()

    private var widgetsSection: NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 4.0
        return section
    }

    private lazy var group: NSCollectionLayoutGroup = {
        NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    }()

    private lazy var groupSize: NSCollectionLayoutSize = {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.95),
            heightDimension: .estimated(300.0)
        )
        return size
    }()

    private lazy var item: NSCollectionLayoutItem = {
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        return item
    }()

    private lazy var size: NSCollectionLayoutSize = {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        return size
    }()
}
