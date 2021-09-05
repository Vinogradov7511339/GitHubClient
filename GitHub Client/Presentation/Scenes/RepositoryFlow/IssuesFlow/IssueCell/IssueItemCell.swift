//
//  IssueItemCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 16.08.2021.
//

import UIKit

class IssueItemCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var issueNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var labelsStackView: UIStackView!
    @IBOutlet weak var commentsView: UIView!
    @IBOutlet weak var commentsCountLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension IssueItemCell: ConfigurableCell {
    func configure(viewModel: Issue) {
        issueNameLabel.text = name(viewModel.repositoryUrl, number: viewModel.number)
        titleLabel.text = viewModel.title
        commentsView.isHidden = viewModel.commentsCount == 0
        commentsCountLabel.text = "\(viewModel.commentsCount)"
        addLabels(viewModel.labels)
    }

    func name(_ url: URL, number: Int) -> String {
        let repository = url.pathComponents[url.pathComponents.count - 1]
        let owner = url.pathComponents[url.pathComponents.count - 2]
        return "\(owner) / \(repository) #\(number)"
    }

    func addLabels(_ labels: [LabelResponseDTO]) {
        labelsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        labelsStackView.isHidden = labels.isEmpty
        for lbl in labels {
            let label = UILabel()
            label.text = lbl.name
            label.backgroundColor = UIColor(hex: lbl.color, alpha: 1.0)
            labelsStackView.addArrangedSubview(label)
        }
    }
}
