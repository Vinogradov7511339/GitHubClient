//
//  FolderCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import UIKit

class FolderCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension FolderCell: ConfigurableCell {
    func configure(viewModel: FolderItem) {
        itemTitleLabel.text = viewModel.name
        let imageName: String
        let imageColor: UIColor
        switch viewModel.type {
        case .folder:
            imageName = "folder"
            imageColor = .link
        case .file:
            imageName = "doc"
            imageColor = .secondaryLabel
        }
        itemImageView.image = UIImage(systemName: imageName)
        itemImageView.tintColor = imageColor
    }
}
