//
//  DiffHunkView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.09.2021.
//

import UIKit

final class DiffHunkView: UIView {

    func configure(with diff: String) {

        for hunkType in parse(diff) {
            let label = UILabel()
            label.numberOfLines = 0
            label.font = .systemFont(ofSize: 15.0, weight: .light)

            switch hunkType {
            case .info(let lines):
                label.text = lines.joined(separator: "\n")
                label.backgroundColor = .systemBlue.withAlphaComponent(0.1)

            case .added(let lines):
                label.text = lines.joined(separator: "\n")
                label.backgroundColor = .systemGreen.withAlphaComponent(0.1)

            case .deleted(let lines):
                label.text = lines.joined(separator: "\n")
                label.backgroundColor = .systemRed.withAlphaComponent(0.1)

            case .notModified(let lines):
                label.text = lines.joined(separator: "\n")
                label.backgroundColor = .white
            }

            stackView.addArrangedSubview(label)
        }
    }

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        completeInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        completeInit()
    }

    private func completeInit() {
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubview(stackView)

        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(
            equalTo: scrollView.trailingAnchor, constant: -12.0).isActive = true
        stackView.leadingAnchor.constraint(
            equalTo: scrollView.leadingAnchor, constant: 12.0).isActive = true
        stackView.widthAnchor.constraint(greaterThanOrEqualTo: widthAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    }

    func parse(_ diff: String) -> [HunkBody] {
        var hunks: [HunkBody] = []

        diff.enumerateLines { line, _ in
            switch true {
            case line.hasPrefix(GitPrefix.hunk.rawValue):
                if case .info(var lines) = hunks.last {
                    lines.append(line)
                } else {
                    hunks.append(.info([line]))
                }
            case line.hasPrefix(GitPrefix.addedLine.rawValue):
                if case .added(var lines) = hunks.last {
                    lines.append(line)
                } else {
                    hunks.append(.added([line]))
                }
            case line.hasPrefix(GitPrefix.deletedLine.rawValue):
                if case .deleted(var lines) = hunks.last {
                    lines.append(line)
                } else {
                    hunks.append(.deleted([line]))
                }
            default:
                if case .notModified(var lines) = hunks.last {
                    lines.append(line)
                } else {
                    hunks.append(.notModified([line]))
                }
            }
        }
        return hunks
    }

    enum HunkBody {
        case info([String])
        case added([String])
        case deleted([String])
        case notModified([String])
    }

    enum GitPrefix: String {
        case hunk = "@@"
        case addedLine = "+"
        case deletedLine = "-"
    }
}
