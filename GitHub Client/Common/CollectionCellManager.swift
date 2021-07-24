//
//  CollectionCellManager.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit
class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        completeInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        completeInit()
    }
    
    func completeInit() { }
    
    func populate(viewModel: Any) { }
}

class CollectionCellManager {
    func register(collectionView: UICollectionView) {}
    func dequeueReusableCell(collectionView: UICollectionView, for indexPath: IndexPath) -> BaseCollectionViewCell {
        fatalError("should be overriden in descendant")
    }
    
    static func create<CellType: BaseCollectionViewCell & NibLoadable>(cellType: CellType.Type) -> CollectionCellManager {
        return CollectionNibCellManager(cellType: cellType)
    }
    
    static func create<CellType: BaseCollectionViewCell>(cellType: CellType.Type) -> CollectionCellManager {
        return CollectionTypeCellManager(cellType: cellType)
    }
}

class CollectionNibCellManager<CellType: BaseCollectionViewCell & NibLoadable>: CollectionCellManager {
    
    let cellType: CellType.Type
    
    init(cellType: CellType.Type) {
        self.cellType = cellType
    }
    
    override func register(collectionView: UICollectionView) {
        collectionView.register(nib: cellType.nib, cellType: cellType)
    }
    
    override func dequeueReusableCell(collectionView: UICollectionView, for indexPath: IndexPath) -> BaseCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withType: cellType, for: indexPath)
        return cell
    }
}

class CollectionTypeCellManager<CellType: BaseCollectionViewCell>: CollectionCellManager {
    
    let cellType: CellType.Type
    
    init(cellType: CellType.Type) {
        self.cellType = cellType
    }
    
    override func register(collectionView: UICollectionView) {
        collectionView.register(cellType: cellType)
    }
    
    override func dequeueReusableCell(collectionView: UICollectionView, for indexPath: IndexPath) -> BaseCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withType: cellType, for: indexPath)
        return cell
    }
}

extension UICollectionView {
    func register<CellType: UICollectionViewCell>(cellType: CellType.Type) {
        register(cellType, forCellWithReuseIdentifier: identifier(for: cellType))
    }
    
    func register<CellType: UICollectionViewCell>(nib: UINib, cellType: CellType.Type) {
        register(nib, forCellWithReuseIdentifier: identifier(for: cellType))
    }
    
    func dequeueReusableCell<CellType: UICollectionViewCell>(withType type: CellType.Type, for indexPath: IndexPath) -> CellType {
        return dequeueReusableCell(withReuseIdentifier: identifier(for: type), for: indexPath) as! CellType
    }
    
    private func identifier<CellType: UICollectionViewCell>(for cellType: CellType.Type) -> String {
        return String(describing: cellType)
    }
}
