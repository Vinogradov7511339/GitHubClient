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
        let image: UIImage?
        let imageColor: UIColor
        switch viewModel.type {
        case .folder:
            image = UIImage.Repository.folderBlue
            imageColor = .systemBlue
        case .file:
            image = UIImage.Repository.file
            imageColor = .lightGray
        }
        itemImageView.image = image
        itemImageView.tintColor = imageColor
    }
}
