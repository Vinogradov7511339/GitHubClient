//
//  DiffCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 29.08.2021.
//

import UIKit
import TextCompiler

class DiffCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var hunkLabel: UILabel!
    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

extension DiffCell: ConfigurableCell {
    func configure(viewModel: Diff) {
        fileNameLabel.text = viewModel.diffInfo
        hunkLabel.attributedText = convertHunk(viewModel.hunk)
    }

    func convertHunk(_ hunk: Hunk) -> NSAttributedString {
        var lines: [NSAttributedString] = []
        for lineType in hunk.lines {
            switch lineType {
            case .added(let line):
                lines.append(addLineAttr(line))
            case .deleted(let line):
                lines.append(deleteLineAttr(line))
            case .notModified(let line):
                let attrStr = NSAttributedString(string: "\(line) \n")
                lines.append(attrStr)
            }
        }
        let attrHeader = hangHeaderAttr(hunk.info)
        let attrStr = NSMutableAttributedString(attributedString: attrHeader)
        lines.forEach { attrStr.append($0) }
        return attrStr
    }

    func hangHeaderAttr(_ str: String) -> NSAttributedString {
        let attr: [NSAttributedString.Key: Any] =
            [.backgroundColor: UIColor.systemBlue.withAlphaComponent(0.4)]
        return NSAttributedString(string: "\(str) \n", attributes: attr)
    }

    func addLineAttr(_ str: String) -> NSAttributedString {
        let attr: [NSAttributedString.Key: Any] =
            [.backgroundColor: UIColor.systemGreen.withAlphaComponent(0.4)]
        return NSAttributedString(string: "\(str) \n", attributes: attr)
    }

    func deleteLineAttr(_ str: String) -> NSAttributedString {
        let attr: [NSAttributedString.Key: Any] =
            [.backgroundColor: UIColor.systemRed.withAlphaComponent(0.4)]
        return NSAttributedString(string: "\(str) \n", attributes: attr)
    }
}
