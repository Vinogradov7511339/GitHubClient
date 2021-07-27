//
//  IssueTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit

//struct IssueCellViewModel {
//    let image: UIImage?
//    let repositoryName: String
//    let name: String
//    let date: String
//    let bottomImage: UIImage?
//}

class IssueTableViewCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
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

extension IssueTableViewCell: ConfigurableCell {
    func configure(viewModel: Issue) {
        itemImageView.image = UIImage(named: "")
//        repositoryNameLabel.text = viewModel.repositoryName
//        nameLabel.text = viewModel.name
//        dateLabel.text = viewModel.date
    }
}
