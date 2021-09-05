//
//  DiffView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.09.2021.
//

import UIKit

struct CommitDiffCellViewModel {
    var isExpanded: Bool
    let file: DiffFileResponseDTO
}

final class DiffView: UIView {

    func configure(with viewModel: CommitDiffCellViewModel) {
        headerView.configure(fileName: viewModel.file.filename, isExpanded: viewModel.isExpanded)
        hunkView.configure(with: viewModel.file.patch ?? "")

        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(hunkView)
    }

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var headerView: DiffHeaderView = {
        let view = DiffHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()

    private lazy var hunkView: DiffHunkView = {
        let view = DiffHunkView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

// MARK: - DiffHeaderViewDelegate
extension DiffView: DiffHeaderViewDelegate {
    func expandButtonTapped() {
        hunkView.isHidden = !hunkView.isHidden
    }
}
