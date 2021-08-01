//
//  DetailTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

struct DetailCellViewModel {
    let avatarUrl: URL?
    let title: String
    let subtitle: String
    
    init(repository: Repository) {
        avatarUrl = repository.owner?.avatarUrl
        title = repository.owner?.login ?? ""
        subtitle = repository.name ?? ""
    }
}

class DetailTableViewCell: BaseTableViewCell, NibLoadable {

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

extension DetailTableViewCell: ConfigurableCell {
    func configure(viewModel: DetailCellViewModel) {
        (imageView as? WebImageView)?.set(url: viewModel.avatarUrl)
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.subtitle
    }
}
