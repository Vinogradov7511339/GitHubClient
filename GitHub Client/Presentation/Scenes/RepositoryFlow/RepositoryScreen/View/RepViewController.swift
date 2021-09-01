//
//  RepViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class RepViewController: UIViewController {

    enum SegmentType: Int, CaseIterable {
        case info
        case activity

        var title: String {
            switch self {
            case .info:
                return NSLocalizedString("Info", comment: "")
            case .activity:
                return NSLocalizedString("Activity", comment: "")
            }
        }
    }

    // MARK: - Create

    static func create(with viewModel: RepViewModel) -> RepViewController {
        let viewController = RepViewController()
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

    private lazy var infoViewController: RepositoryInfoViewController = {
        let viewController = RepositoryInfoViewController.create(with: viewModel)
        return viewController
    }()

    private lazy var activityViewController: RepositoryActivityViewController = {
        let viewController = RepositoryActivityViewController.create(with: viewModel)
        return viewController
    }()

    // MARK: - Private variables

    private var viewModel: RepViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        configureNavBar()

        view.bringSubviewToFront(infoViewController.view)
        viewModel.viewDidLoad()
    }
}

// MARK: - Actions
extension RepViewController {
    @objc func segmentValueChanged() {
        let newValue = segmentControl.selectedSegmentIndex
        guard let sectionType = SegmentType(rawValue: newValue) else { return }
        switch sectionType {
        case .info:
            view.bringSubviewToFront(infoViewController.view)
        case .activity:
            view.bringSubviewToFront(activityViewController.view)
        }
    }

    @objc func share() {
        viewModel.share()
    }
}

// MARK: - setup views
private extension RepViewController {
    func setupViews() {
        addChild(infoViewController)
        addChild(activityViewController)
        view.addSubview(infoViewController.view)
        view.addSubview(activityViewController.view)
    }

    func activateConstraints() {}

    func configureNavBar() {
        navigationItem.titleView = segmentControl
        let share = UIBarButtonItem(barButtonSystemItem: .action,
                                    target: self,
                                    action: #selector(share))
        navigationItem.rightBarButtonItem = share
    }
}
