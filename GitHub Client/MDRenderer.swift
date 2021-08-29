//
//  MDRenderer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 29.08.2021.
//

import UIKit
import TextCompiler

final class MDRenderer {

    private let parser: MDParser

    init(text: String) {
        parser = MDParser(raw: text)
    }

    func render(in stackView: UIStackView) {
        fill(stackView: stackView)
    }

    private func fill(stackView: UIStackView) {
        let items = parser.parse()
        for item in items {
            switch item {
            case .text(let textTypes):
                let view = textView(textTypes)
                stackView.addArrangedSubview(view)

            case .header(let header):
                let view = headerView(header)
                stackView.addArrangedSubview(view)

            case .bulletItem(let item):
                let view = bulletView(item)
                stackView.addArrangedSubview(view)

            case .codeBlock(let codeLines):
                let view = codeView(codeLines)
                stackView.addArrangedSubview(view)

            case .image(let imageInfo):
                let view = imageView(imageInfo)
                stackView.addArrangedSubview(view)
            }
        }
    }
}

// MARK: - Views
private extension MDRenderer {
    func textView(_ textTypes: [TextType]) -> UIView {
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = attributedString(from: textTypes)
        return label
    }

    func headerView(_ header: String) -> UIView {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 17.0)
        label.text = header
        return label
    }

    func bulletView(_ item: String) -> UIView {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17.0)
        label.text = "  ~\(item)"
        return label
    }

    func codeView(_ lines: [String]) -> UIView {
        let label = UILabel()
        label.backgroundColor = .systemGroupedBackground
        label.text = lines.joined(separator: "\n")
        return label
    }

    func imageView(_ imageInfo: [String]) -> UIView {
        let imageView = WebImageView()
        let imageURL = URL(string: "temp")
        imageView.set(url: imageURL)
        return imageView
    }
}

// MARK: - Attributes
private extension MDRenderer {

    typealias Attributes = [NSAttributedString.Key: Any]

    func attributedString(from textTypes: [TextType]) -> NSAttributedString {
        let totalAttrString = NSMutableAttributedString()
        for textType in textTypes {
            switch textType {
            case .link(let text, let link):
                let attrStr = linkAttributedString(text, link: link)
                totalAttrString.append(attrStr)

            case .bold(let text):
                let attr: Attributes = [.font: UIFont.boldSystemFont(ofSize: 14.0)]
                let attrStr = NSAttributedString(string: text, attributes: attr)
                totalAttrString.append(attrStr)

            case .italic(let text):
                let attr: Attributes = [.font: UIFont.italicSystemFont(ofSize: 14.0)]
                let attrStr = NSAttributedString(string: text, attributes: attr)
                totalAttrString.append(attrStr)

            case .text(let text):
                let attrString = NSAttributedString(string: text)
                totalAttrString.append(attrString)
            }
        }

        return totalAttrString
    }

    func linkAttributedString(_ text: String, link: String) -> NSAttributedString {
        let attrStr = NSMutableAttributedString(string: text, attributes: [:])
        let foundRange = attrStr.mutableString.range(of: text)
        attrStr.addAttribute(.link, value: link, range: foundRange)
        return attrStr
    }
}
