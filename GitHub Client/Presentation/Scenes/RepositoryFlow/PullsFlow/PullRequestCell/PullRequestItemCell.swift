//
//  PullRequestItemCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

class PullRequestItemCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var pullNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var labelsStackView: UIStackView!
    @IBOutlet weak var infoStackView: UIStackView!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

extension PullRequestItemCell: ConfigurableCell {
    func configure(viewModel: PullRequest) {
        pullNameLabel.text = name(viewModel.url, number: viewModel.number)
        titleLabel.text = viewModel.title
        addLabels(viewModel.labels)
    }

    func name(_ url: URL, number: Int) -> String {
        let repository = url.pathComponents[url.pathComponents.count - 3]
        let owner = url.pathComponents[url.pathComponents.count - 4]
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
