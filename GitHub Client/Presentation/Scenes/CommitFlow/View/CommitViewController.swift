//
//  CommitViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 28.08.2021.
//

import UIKit

final class CommitViewController: UIViewController {

    enum SegmentType: Int, CaseIterable {
        case diff
        case info

        var title: String {
            switch self {
            case .diff:
                return NSLocalizedString("Changes", comment: "")
            case .info:
                return NSLocalizedString("Details", comment: "")
            }
        }
    }

    // MARK: - Create

    static func create(with viewModel: CommitViewModel) -> CommitViewController {
        let viewController = CommitViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var segmentControl: UISegmentedControl = {
        let items = SegmentType.allCases.map { $0.title }
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        return segmentControl
    }()

    private lazy var diffViewController: UIViewController = {
        let viewController = DiffTempViewController.create(with: viewModel)
        return viewController
    }()

    private lazy var infoViewController: UIViewController = {
        let viewController = CommitInfoViewController.create(with: viewModel)
        return viewController
    }()

    // MARK: - Private variables

    private var viewModel: CommitViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        configureNavBar()

        view.bringSubviewToFront(diffViewController.view)
        viewModel.viewDidLoad()
    }
}

// MARK: - Actions
extension CommitViewController {
    @objc func segmentValueChanged() {
        let newValue = segmentControl.selectedSegmentIndex
        guard let sectionType = SegmentType(rawValue: newValue) else { return }
        switch sectionType {
        case .diff:
            view.bringSubviewToFront(diffViewController.view)
        case .info:
            view.bringSubviewToFront(infoViewController.view)
        }
    }
}

// MARK: - Setup views
private extension CommitViewController {
    func setupViews() {
        addChild(diffViewController)
        addChild(infoViewController)
        view.addSubview(diffViewController.view)
        view.addSubview(infoViewController.view)
    }

    func activateConstraints() {}

    func configureNavBar() {
        navigationItem.titleView = segmentControl
    }
}
