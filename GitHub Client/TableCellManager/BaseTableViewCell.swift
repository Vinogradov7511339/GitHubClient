//
//  BaseTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.07.2021.
//

import UIKit

protocol ConfigurableCell {
    associatedtype ViewModel

    func configure(viewModel: ViewModel)
}

extension ConfigurableCell {
    func configure(viewModel: Any) {
        guard let viewModel = viewModel as? ViewModel else {
            return
        }
        configure(viewModel: viewModel)
    }
}

class BaseTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        completeInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        completeInit()
    }

    class func cellHeight(for viewModel: Any) -> CGFloat {
        return UITableView.automaticDimension
    }

    func completeInit() { }

    func populate(viewModel: Any) { }
}
