//
//  MyRepositoryTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.07.2021.
//

import UIKit

class MyRepositoryTableViewCell: BaseTableViewCell, NibLoadable {
    
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var starredImageView: UIImageView!
    @IBOutlet weak var languageImageView: UIImageView!
    @IBOutlet weak var starsCountLabel: UILabel!
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

extension MyRepositoryTableViewCell: ConfigurableCell {
    func configure(viewModel: Repository) {
        repositoryNameLabel.text = viewModel.name ?? ""
        languageLabel.text = viewModel.language ?? ""
        starsCountLabel.text = "\(viewModel.stargazers_count ?? 0)"
//        starredImageView
//        languageImageView
    }
}
