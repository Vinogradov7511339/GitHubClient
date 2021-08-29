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
            case .text(let lines):
                let view = textView(lines)
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
    func textView(_ text: [String]) -> UIView {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = text.joined(separator: "\n")
        return label
    }

    func headerView(_ header: String) -> UIView {
        let label = UILabel()
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
