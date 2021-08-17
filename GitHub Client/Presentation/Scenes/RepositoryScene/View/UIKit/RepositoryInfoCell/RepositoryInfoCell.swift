//
//  RepositoryInfoCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 17.08.2021.
//

import UIKit

struct RepositoryInfoCellViewModel {
    enum CellType: Int {
        case issues
        case pullRequests
        case releases
        case license
    }

    let type: CellType
    let repository: Repository
}

class RepositoryInfoCell: BaseTableViewCell, NibLoadable {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
