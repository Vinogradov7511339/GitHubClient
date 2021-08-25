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

    private lazy var group: NSCollectionLayoutGroup = {
        NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
    }()

    private lazy var item: NSCollectionLayoutItem = {
        NSCollectionLayoutItem(layoutSize: size)
    }()

    private lazy var size: NSCollectionLayoutSize = {
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
            heightDimension: NSCollectionLayoutDimension.estimated(75)
        )
        return size
    }()
}

// MARK: - Widgets
private extension ExploreLayout {
    var widgetsSection: NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        section.interGroupSpacing = 4.0
        section.boundarySupplementaryItems = [widgetsHeader]
        return section
    }

    var widgetsHeader: NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(layoutSize: widgetsHeaderSize,
                                                    elementKind: HomeVC.sectionHeaderElementKind,
                                                    alignment: .top)
    }

    var widgetsHeaderSize: NSCollectionLayoutSize {
        NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .estimated(40.0))
    }
}
