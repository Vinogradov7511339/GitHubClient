//
//  UserActivityCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.08.2021.
//

import UIKit

class UserActivityCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var activityCollectionView: UICollectionView!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension UserActivityCell: ConfigurableCell {
    func configure(viewModel: UserProfile) {}
}
