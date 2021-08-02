//
//  RecentEventsTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit

struct RecentEventsCellViewModel {
    let eventImage: UIImage?
    let eventName: String
    let eventTitle: String
    let authorName: String?
    let date: String
    let badgeCount: Int?

    init(issue: Issue) {
        eventImage = UIImage.issue
        eventName = issue.repository?.fullName ?? ""
        eventTitle = issue.title ?? ""
        authorName = issue.user?.name ?? ""
        date = ""
        badgeCount = nil
    }
}

class RecentEventsTableViewCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var badgeLabel: UILabel!

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

extension RecentEventsTableViewCell: ConfigurableCell {
    func configure(viewModel: RecentEventsCellViewModel) {
        eventImageView.image = viewModel.eventImage
        eventNameLabel.text = viewModel.eventName
        eventTitleLabel.text = viewModel.eventTitle
        authorNameLabel.text = viewModel.authorName
        dateLabel.text = viewModel.date
        badgeLabel.isHidden = true
        //todo badge
    }
}
