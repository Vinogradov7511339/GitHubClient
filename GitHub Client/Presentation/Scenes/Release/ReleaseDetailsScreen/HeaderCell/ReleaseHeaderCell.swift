//
//  ReleaseHeaderCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.09.2021.
//

import UIKit

class ReleaseHeaderCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var reactionsStackView: UIStackView!
    @IBOutlet weak var plusOneButton: UIButton!
    @IBOutlet weak var laughButton: UIButton!
    @IBOutlet weak var hoorayButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var rocketButton: UIButton!
    @IBOutlet weak var eyesButton: UIButton!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension ReleaseHeaderCell: ConfigurableCell {
    func configure(viewModel: Release) {
        avatarImageView.set(url: viewModel.author.avatarUrl)
        loginButton.setTitle(viewModel.author.login, for: .normal)
        versionLabel.text = viewModel.tagName
        bodyLabel.text = viewModel.body
    }
}
