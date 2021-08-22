//
//  UITableView+extensions.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.07.2021.
//

import UIKit

extension UITableView {
    func register<CellType: UITableViewCell>(cellType: CellType.Type) {
        register(cellType, forCellReuseIdentifier: identifier(for: cellType))
    }

    func register<CellType: UITableViewCell>(nib: UINib, cellType: CellType.Type) {
        register(nib, forCellReuseIdentifier: identifier(for: cellType))
    }

    func dequeueReusableCell<CellType: UITableViewCell>(withType type: CellType.Type,
                                                        for indexPath: IndexPath) -> CellType? {
        return dequeueReusableCell(withIdentifier: identifier(for: type), for: indexPath) as? CellType
    }

    private func identifier<CellType: UITableViewCell>(for cellType: CellType.Type) -> String {
        return String(describing: cellType)
    }
}
