//
//  MyProfileInfoCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 01.09.2021.
//

import UIKit

class MyProfileInfoCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var blogButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var companyButton: UIButton!
    @IBOutlet weak var publicRepsButton: UIButton!
    @IBOutlet weak var privateRepsButton: UIButton!
    @IBOutlet weak var publicGistsButton: UIButton!
    @IBOutlet weak var privateGistsButton: UIButton!

    @IBOutlet weak var publicReposStackView: UIStackView!
    @IBOutlet weak var privateReposStackView: UIStackView!
    @IBOutlet weak var publicGistsStackView: UIStackView!
    @IBOutlet weak var privateGistsStackView: UIStackView!


    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

extension MyProfileInfoCell: ConfigurableCell {
    func configure(viewModel: AuthenticatedUser) {
        let user = viewModel.userDetails
        setTitle(user.name, for: nameButton)
        setTitle(user.userEmail, for: emailButton)
        setTitle(user.userBlogUrl?.absoluteString, for: blogButton)
        setTitle(user.location, for: locationButton)
        setTitle(user.company, for: companyButton)
        
        setTitle(viewModel.publicRepCount.roundedWithAbbreviations, for: publicRepsButton)
        setTitle(viewModel.privateRepCount.roundedWithAbbreviations, for: privateRepsButton)
        setTitle(viewModel.publicGistsCount.roundedWithAbbreviations, for: publicGistsButton)
        setTitle(viewModel.privateGistsCount.roundedWithAbbreviations, for: privateGistsButton)

        publicReposStackView.isHidden = viewModel.publicRepCount == 0
        privateReposStackView.isHidden = viewModel.privateRepCount == 0
        publicGistsStackView.isHidden = viewModel.publicGistsCount == 0
        privateGistsStackView.isHidden = viewModel.privateGistsCount == 0
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
