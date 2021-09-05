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
    @IBOutlet weak var minusOneButton: UIButton!
    @IBOutlet weak var confusedButton: UIButton!
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
        guard let reactions = viewModel.reactions else { return }

        plusOneButton.setTitle("👍\(reactions.plusOne)", for: .normal)
        minusOneButton.setTitle("👎\(reactions.minusOne)", for: .normal)
        laughButton.setTitle("😄\(reactions.laugh)", for: .normal)
        hoorayButton.setTitle("🎉\(reactions.hooray)", for: .normal)
        heartButton.setTitle("❤️\(reactions.heart)", for: .normal)
        rocketButton.setTitle("🚀\(reactions.rocket)", for: .normal)
        eyesButton.setTitle("👀\(reactions.eyes)", for: .normal)
        confusedButton.setTitle("😕\(reactions.confused)", for: .normal)

        plusOneButton.isHidden = reactions.plusOne == 0
        minusOneButton.isHidden = reactions.minusOne == 0
        laughButton.isHidden = reactions.laugh == 0
        hoorayButton.isHidden = reactions.hooray == 0
        heartButton.isHidden = reactions.heart == 0
        rocketButton.isHidden = reactions.rocket == 0
        eyesButton.isHidden = reactions.eyes == 0
        confusedButton.isHidden = reactions.confused == 0
    }
}
