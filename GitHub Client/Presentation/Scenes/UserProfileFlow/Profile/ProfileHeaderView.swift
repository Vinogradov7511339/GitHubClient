//
//  ProfileHeaderView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

protocol ProfileHeaderViewProtocol: UIView {
    var minHeight: CGFloat { get }
    var defaultHeight: CGFloat { get }
    var delegate: ProfileHeaderViewDelegate? { get set }

    func maxHeight(for profile: UserProfile) -> CGFloat
    func update(with profile: UserProfile)
    func updateHeight(_ percent: CGFloat)
}

protocol ProfileHeaderViewDelegate: AnyObject {
    func backButtonTouched()
    func subscribeButtonTouched()
    func gistsButtonTouched()
    func followersButtonTouched()
    func followingButtonTouched()
}

final class ProfileHeaderView: UIView {

    // MARK: - ProfileHeaderViewProtocol

    var minHeight: CGFloat = 50
    var defaultHeight: CGFloat = 250

    weak var delegate: ProfileHeaderViewDelegate?

    // MARK: - Views

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var gistsCount: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var publicRepsCountLabel: UILabel!
    @IBOutlet weak var infoStackView: UIStackView!

    // MARK: - Constraints

    @IBOutlet weak var avatarTop: NSLayoutConstraint!
    @IBOutlet weak var loginLeading: NSLayoutConstraint!
    @IBOutlet weak var notificationTrailing: NSLayoutConstraint!
    @IBOutlet weak var titleTop: NSLayoutConstraint!
    @IBOutlet weak var popularStackViewCenterX: NSLayoutConstraint!
    @IBOutlet weak var infoStackViewCenterX: NSLayoutConstraint!
    @IBOutlet weak var infoButtonLeading: NSLayoutConstraint!

    // MARK: - Actions

    @IBAction func backButtonTouched(_ sender: UIButton) {
        delegate?.backButtonTouched()
    }

    @IBAction func subscribeButtonTouched(_ sender: UIButton) {
        delegate?.subscribeButtonTouched()
    }
    
    @IBAction func gistsButtonTouched(_ sender: UIButton) {
        delegate?.gistsButtonTouched()
    }

    @IBAction func followersButtonTouched(_ sender: UIButton) {
        delegate?.followersButtonTouched()
    }

    @IBAction func followingButtonTouched(_ sender: UIButton) {
        delegate?.followingButtonTouched()
    }
}

// MARK: - ProfileHeaderViewProtocol
extension ProfileHeaderView: ProfileHeaderViewProtocol {

    func maxHeight(for profile: UserProfile) -> CGFloat {
        let stackItemHeight: CGFloat = 21
        var minHeight = defaultHeight
        if profile.name != nil {
            minHeight += stackItemHeight
        }
        if profile.userEmail != nil {
            minHeight += stackItemHeight
        }
        if profile.company != nil {
            minHeight += stackItemHeight
        }
        if profile.location != nil {
            minHeight += stackItemHeight
        }
        if profile.userBlogUrl?.absoluteString != nil {
            minHeight += stackItemHeight
        }
        return minHeight
    }

    func update(with profile: UserProfile) {
        updateViews(profile)
    }

    func updateHeight(_ percent: CGFloat) {
        updateAvatar(percent)
        updateLogin(percent)
        updateNotification(percent)
        updateTitle(percent)
        updatePopularStackView(percent)
        updateInfoLeading(percent)
        updateInfoStackView(percent)
    }
}

// MARK: - Constraints
private extension ProfileHeaderView {
    func updateAvatar(_ percent: CGFloat) {
        let top = max(24, 60 * percent)
        avatarTop.constant = top
    }

    func updateLogin(_ percent: CGFloat) {
        let leading = -((1 - percent) * 100) + 16
        loginLeading.constant = leading
    }

    func updateNotification(_ percent: CGFloat) {
        let trailing = -((1 - percent) * 44) + 12
        notificationTrailing.constant = trailing
    }

    func updateTitle(_ percent: CGFloat) {
        let top = -(percent * 56) + 32
        titleTop.constant = top
    }

    func updatePopularStackView(_ percent: CGFloat) {
        let centerX = (1 - percent) * bounds.width
        popularStackViewCenterX.constant = centerX
    }

    func updateInfoLeading(_ percent: CGFloat) {
        let leading = -((1 - percent) * 100) + 16
        infoButtonLeading.constant = leading
    }

    func updateInfoStackView(_ percent: CGFloat) {
        let centerX = (1 - percent) * bounds.width
        infoStackViewCenterX.constant = centerX
    }
}

// MARK: - Fill views
private extension ProfileHeaderView {
    func updateViews(_ profile: UserProfile) {
        avatarImageView.set(url: profile.user.avatarUrl)
        gistsCount.text = profile.gistsCount.roundedWithAbbreviations
        followersCountLabel.text = profile.followersCount.roundedWithAbbreviations
        followingCountLabel.text = profile.followingCount.roundedWithAbbreviations
        publicRepsCountLabel.text = profile.repositoriesCount.roundedWithAbbreviations

        infoStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        if let name = profile.name {
            let title = NSLocalizedString("name", comment: "")
            add(title, name)
        }
        if let email = profile.userEmail {
            let title = NSLocalizedString("email", comment: "")
            add(title, email)
        }
        if let company = profile.company {
            let title = NSLocalizedString("company", comment: "")
            add(title, company)
        }
        if let location = profile.location {
            let title = NSLocalizedString("location", comment: "")
            add(title, location)
        }
        if let link = profile.userBlogUrl?.absoluteString {
            let title = NSLocalizedString("blog", comment: "")
            add(title, link)
        }
    }

    func add(_ title: String, _ value: String) {
        let titleLabel = UILabel()
        titleLabel.textColor = .white.withAlphaComponent(0.8)
        titleLabel.textAlignment = .left
        titleLabel.text = title

        let valueLabel = UILabel()
        valueLabel.textColor = .white
        valueLabel.font = .boldSystemFont(ofSize: 14.0)
        valueLabel.textAlignment = .right
        valueLabel.text = value

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)

        infoStackView.addArrangedSubview(stackView)
    }
}

// MARK: - Temp
extension ProfileHeaderView {
    class func instanceFromNib() -> ProfileHeaderView {
        if let view = Bundle.main.loadNibNamed("ProfileHeaderView",
                                               owner: self,
                                               options: nil)?[0] as? ProfileHeaderView {
            return view
        } else {
            fatalError()
        }
    }
}
