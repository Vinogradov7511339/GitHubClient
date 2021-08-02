//
//  MyRepositoryTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.07.2021.
//

import UIKit

class MyReposTableViewCell: BaseTableViewCell, NibLoadable {
    
    @IBOutlet weak var reposNameLabel: UILabel!
    @IBOutlet weak var reposDescriptionLabel: UILabel!
    @IBOutlet weak var isStarredImageView: UIImageView!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var languageColorImageView: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

extension MyReposTableViewCell: ConfigurableCell {
    func configure(viewModel: RepositoryResponse) {
        reposNameLabel.text = viewModel.name ?? ""
        if let description = viewModel.description {
            reposDescriptionLabel.isHidden = false
            reposDescriptionLabel.text = description
        } else {
            reposDescriptionLabel.isHidden = true
        }
        //        isStarredImageView todo
        if let language = viewModel.language {
            languageColorImageView.isHidden = false
            languageLabel.isHidden = false
            languageColorImageView.tintColor = UIColor.getLanguageColor(for: language)
            languageLabel.text = language
        } else {
            languageColorImageView.isHidden = true
            languageLabel.isHidden = true
        }
    }
}
