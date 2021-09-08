//
//  CompositionalLayout.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 15.08.2021.
//

import UIKit

class CompositionalLayoutFactory {
    typealias SupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem

    lazy var layout: UICollectionViewCompositionalLayout = {
        UICollectionViewCompositionalLayout(section: section)
    }()

    private lazy var section: NSCollectionLayoutSection = {
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        section.interGroupSpacing = 16.0
        section.boundarySupplementaryItems = [footer]
        return section
    }()

    private lazy var footer: SupplementaryItem = {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44.0))
        return SupplementaryItem(layoutSize: size, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
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
            heightDimension: NSCollectionLayoutDimension.estimated(300)
        )
        return size
    }()
}
