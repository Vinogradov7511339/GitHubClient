//
//  RepositoryCodeCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 17.08.2021.
//

import UIKit

struct RepositoryCodeCellViewModel {
    enum CellType: Int {
        case code
        case commits
    }

    let type: CellType
}

class RepositoryCodeCell: BaseTableViewCell, NibLoadable {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
