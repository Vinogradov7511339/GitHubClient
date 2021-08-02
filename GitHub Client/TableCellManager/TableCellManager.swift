//
//  CellManager.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.07.2021.
//

import UIKit

class TableCellManager {
    
    func register(tableView: UITableView) { }

    func dequeueReusableCell(tableView: UITableView, for indexPath: IndexPath) -> BaseTableViewCell {
        fatalError("should be overriden in descendant")
    }

    func height(for model: Any) -> CGFloat {
        return UITableView.automaticDimension
    }

    static func create<CellType: BaseTableViewCell & NibLoadable>(cellType: CellType.Type) -> TableCellManager {
        return NibCellManager<CellType>(cellType: cellType)
    }

    static func create<CellType: BaseTableViewCell>(cellType: CellType.Type) -> TableCellManager {
        return TypeCellManager<CellType>(cellType: cellType)
    }
}

class NibCellManager<CellType: BaseTableViewCell & NibLoadable>: TableCellManager {
    let cellType: CellType.Type

    init(cellType: CellType.Type) {
        self.cellType = cellType
    }

    override func register(tableView: UITableView) {
        tableView.register(nib: cellType.nib, cellType: cellType)
    }

    override func dequeueReusableCell(tableView: UITableView, for indexPath: IndexPath) -> BaseTableViewCell {
        let cell = tableView.dequeueReusableCell(withType: self.cellType, for: indexPath)
        return cell ?? BaseTableViewCell()
    }

    override func height(for model: Any) -> CGFloat {
        return cellType.cellHeight(for: model)
    }
}

class TypeCellManager<CellType: BaseTableViewCell>: TableCellManager {
    let cellType: CellType.Type

    init(cellType: CellType.Type) {
        self.cellType = cellType
    }

    override func register(tableView: UITableView) {
        tableView.register(cellType: cellType)
    }

    override func dequeueReusableCell(tableView: UITableView, for indexPath: IndexPath) -> BaseTableViewCell {
        let cell = tableView.dequeueReusableCell(withType: self.cellType, for: indexPath)
        return cell ?? BaseTableViewCell()
    }

    override func height(for model: Any) -> CGFloat {
        return cellType.cellHeight(for: model)
    }
}
