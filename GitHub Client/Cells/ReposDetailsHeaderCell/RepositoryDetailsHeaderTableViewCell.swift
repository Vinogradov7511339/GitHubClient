//
//  RepositoryDetailsHeaderTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.07.2021.
//

import UIKit

struct RepositoryDetailsHeaderCellViewModel {
    let repository: Repository
}

class RepositoryDetailsHeaderTableViewCell: BaseTableViewCell, NibLoadable {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var linkStackView: UIStackView!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var starsAndFolksStackView: UIStackView!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var watchButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

extension RepositoryDetailsHeaderTableViewCell: ConfigurableCell {
    func configure(viewModel: RepositoryDetailsHeaderCellViewModel) {
        let repository = viewModel.repository
        ownerNameLabel.text = repository.owner?.name ?? ""
        repositoryNameLabel.text = repository.name ?? ""
        
        starsCountLabel.text = "\(repository.stargazersCount ?? 0) Stars"
        forksCountLabel.text = "\(repository.forksCount ?? 0) Forks"
        
        if let description = repository.description, !description.isEmpty {
            aboutLabel.isHidden = false
            aboutLabel.text = repository.description ?? ""
        } else {
            aboutLabel.isHidden = true
        }
        
        if let url = repository.url {
            linkLabel.text = url.absoluteString
            linkStackView.isHidden = false
        } else {
            linkStackView.isHidden = true
        }
    }
}
