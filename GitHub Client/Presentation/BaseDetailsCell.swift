//
//  BaseDetailsCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

import UIKit

struct BaseDetailsCellViewModel {
    let color: UIColor
    let image: UIImage?
    let title: String

    static var issue: BaseDetailsCellViewModel {
        .init(color: .issue, image: .issue, title: .issue)
    }

    static var pullRequests: BaseDetailsCellViewModel {
        .init(color: .pullRequest, image: .pullRequest, title: .pullRequest)
    }

    static var discussions: BaseDetailsCellViewModel {
        .init(color: .discussions, image: .discussions, title: .discussions)
    }

    static var repositories: BaseDetailsCellViewModel {
        .init(color: .repositories, image: .repositories, title: .repositories)
    }

    static var organizations: BaseDetailsCellViewModel {
        .init(color: .organizations, image: .organizations, title: .organizations)
    }

    static var starred: BaseDetailsCellViewModel {
        .init(color: .starred, image: .starred, title: .starred)
    }

    static var releases: BaseDetailsCellViewModel {
        .init(color: .releases, image: .releases, title: .releases)
    }

    static var watchers: BaseDetailsCellViewModel {
        .init(color: .watchers, image: .watchers, title: .watchers)
    }

    static var license: BaseDetailsCellViewModel {
        .init(color: .license, image: .license, title: .license)
    }

    static var following: BaseDetailsCellViewModel {
        .init(color: .license, image: .license, title: "Following Temp")
    }
}

class BaseDetailsCell: BaseTableViewCell, NibLoadable {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension BaseDetailsCell: ConfigurableCell {
    func configure(viewModel: BaseDetailsCellViewModel) {
        itemImageView.backgroundColor = viewModel.color
        itemImageView.image = viewModel.image
        itemLabel.text = viewModel.title
    }
}
