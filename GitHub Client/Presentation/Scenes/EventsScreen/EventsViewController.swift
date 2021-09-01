//
//  EventsViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 01.09.2021.
//

import UIKit

final class EventsViewController: UIViewController {

    enum SegmentType: Int, CaseIterable {
        case events
        case received

        var title: String {
            switch self {
            case .events:
                return NSLocalizedString("Events", comment: "")
            case .received:
                return NSLocalizedString("Received", comment: "")
            }
        }
    }

    // MARK: - Create

    static func create(events: EventsViewModel, received: EventsViewModel) -> EventsViewController {
        let viewController = EventsViewController()
        viewController.eventsViewModel = events
        viewController.receivedViewModel = received
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

    private lazy var eventsViewController: EventsListViewController = {
        let viewController = EventsListViewController.create(with: eventsViewModel)
        return viewController
    }()

    private lazy var receivedViewController: EventsListViewController = {
        let viewController = EventsListViewController.create(with: receivedViewModel)
        return viewController
    }()

    // MARK: - Private variables

    private var eventsViewModel: EventsViewModel!
    private var receivedViewModel: EventsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        configureNavBar()

        view.bringSubviewToFront(eventsViewController.view)
    }
}

// MARK: - Actions
extension EventsViewController {
    @objc func segmentValueChanged() {
        let newValue = segmentControl.selectedSegmentIndex
        guard let sectionType = SegmentType(rawValue: newValue) else { return }
        switch sectionType {
        case .events:
            view.bringSubviewToFront(eventsViewController.view)
        case .received:
            view.bringSubviewToFront(receivedViewController.view)
        }
    }
}

// MARK: - setup views
private extension EventsViewController {
    func setupViews() {
        addChild(eventsViewController)
        addChild(receivedViewController)
        view.addSubview(eventsViewController.view)
        view.addSubview(receivedViewController.view)
    }

    func activateConstraints() {}

    func configureNavBar() {
        navigationItem.titleView = segmentControl
    }
}
