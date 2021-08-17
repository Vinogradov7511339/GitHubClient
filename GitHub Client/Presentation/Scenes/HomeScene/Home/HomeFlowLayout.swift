//
//  HomeFlowLayout.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 17.08.2021.
//

import UIKit

import UIKit

class HomeFlowLayout {
    lazy var layout: UICollectionViewCompositionalLayout = {
        UICollectionViewCompositionalLayout(section: section)
    }()

    private lazy var section: NSCollectionLayoutSection = {
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        section.interGroupSpacing = 16.0
        return section
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
