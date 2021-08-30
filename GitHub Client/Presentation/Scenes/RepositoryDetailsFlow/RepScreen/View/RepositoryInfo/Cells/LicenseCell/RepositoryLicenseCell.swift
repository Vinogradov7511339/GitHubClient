//
//  RepositoryLicenseCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.08.2021.
//

import UIKit

class RepositoryLicenseCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var licenseNameLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension RepositoryLicenseCell: ConfigurableCell {
    func configure(viewModel: RepositoryDetails) {
        if let license = viewModel.repository.license?.split(separator: " ").first {
            licenseNameLabel.text = String(license)
        } else {
            licenseNameLabel.text = NSLocalizedString("None", comment: "")
        }
    }
}
