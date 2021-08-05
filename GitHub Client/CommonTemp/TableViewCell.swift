//
//  TableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.07.2021.
//

import UIKit

struct TableCellViewModel {
    let text: String
    let detailText: String?
    let image: UIImage?
    let imageTintColor: UIColor?
    let accessoryType: UITableViewCell.AccessoryType

    init(text: String,
         detailText: String?,
         image: UIImage?,
         imageTintColor: UIColor?,
         accessoryType: UITableViewCell.AccessoryType) {
        self.text = text
        self.detailText = detailText
        self.image = image
        self.imageTintColor = imageTintColor
        self.accessoryType = accessoryType
    }

    init(text: String, detailText: String) {
        self.text = text
        self.detailText = detailText
        self.image = nil
        self.imageTintColor = nil
        self.accessoryType = .disclosureIndicator
    }

    init(text: String) {
        self.text = text
        self.detailText = nil
        self.image = nil
        self.imageTintColor = nil
        self.accessoryType = .disclosureIndicator
    }
}

class TableViewCell: BaseTableViewCell, ConfigurableCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }

    func configure(viewModel: TableCellViewModel) {
        textLabel?.text = viewModel.text
        detailTextLabel?.text = viewModel.detailText
        imageView?.tintColor = viewModel.imageTintColor
        imageView?.image = viewModel.image
        accessoryType = viewModel.accessoryType
    }
}
