//
//  UserInfoCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 01.09.2021.
//

import UIKit

class UserInfoCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var profileTypeButton: UIButton!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var blogButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var companyButton: UIButton!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension UserInfoCell: ConfigurableCell {
    func configure(viewModel: UserProfile) {
        setTitle(viewModel.user.type.rawValue, for: profileTypeButton)
        setTitle(viewModel.name, for: nameButton)
        setTitle(viewModel.userEmail, for: emailButton)
        setTitle(viewModel.userBlogUrl?.absoluteString, for: blogButton)
        setTitle(viewModel.location, for: locationButton)
        setTitle(viewModel.company, for: companyButton)
    }

    private func setTitle(_ title: String?, for button: UIButton) {
        if let title = title {
            button.indicated(title)
        } else {
            button.notIndicated()
        }
    }
}

private extension UIButton {
    func notIndicated() {
        let title = NSLocalizedString("Not indicated", comment: "")
        setTitle(title, for: .normal)
        setTitleColor(.secondaryLabel, for: .normal)
        isEnabled = false
    }

    func indicated(_ title: String) {
        let title = NSLocalizedString(title, comment: "")
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        isEnabled = true
    }
}
