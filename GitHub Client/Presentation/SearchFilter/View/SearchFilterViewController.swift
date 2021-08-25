//
//  SearchFilterViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.08.2021.
//

import UIKit

final class SearchFilterViewController: UIViewController {

    // MARK: - Create

    static func create(with filterStorage: SearchFilterStorage) -> SearchFilterViewController {
        let viewController = SearchFilterViewController()
        viewController.filterStorage = filterStorage
        return viewController
    }

    // MARK: - Views

    private lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.addTarget(self, action: #selector(segmentControlTapped), for: .touchUpInside)
        return segmentControl
    }()

    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var pageController: SearchFilterPageController = {
        let pageController = SearchFilterPageController.create(with: childControllers,
                                                               dataSource: self)
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        return pageController
    }()

    // MARK: - Private variables

    private var filterStorage: SearchFilterStorage!
    private var items: [String] = SearchFilter.FilterType.allCases.map { $0.rawValue }
    private lazy var childControllers: [UIViewController] = {
        SearchFilter.FilterType.allCases.map {
            SearchFilterItemViewController.create(with: filterStorage.filter, type: $0)
        }
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        configureNavBar()
    }
}

extension SearchFilterViewController {
    @objc func segmentControlTapped() {
        print(segmentControl.selectedSegmentIndex)
    }
}

// MARK: - UIPageViewControllerDataSource
extension SearchFilterViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = childControllers.firstIndex(of: viewController) else {
            return nil
        }

        segmentControl.selectedSegmentIndex = index
        let previousIndex = index - 1
        guard previousIndex >= 0 else {
            return childControllers.last
        }
        guard childControllers.count > previousIndex else {
            return nil
        }
        return childControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = childControllers.firstIndex(of: viewController) else {
            return nil
        }
        segmentControl.selectedSegmentIndex = viewControllerIndex
        let nextIndex = viewControllerIndex + 1
        guard childControllers.count != nextIndex else {
            return childControllers.first
        }

        guard childControllers.count > nextIndex else {
            return nil
        }
        return childControllers[nextIndex]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        childControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = childControllers.first,
              let firstViewControllerIndex = childControllers.firstIndex(of: firstViewController) else {
            return 0
        }
        return firstViewControllerIndex
    }
}

// MARK: - Setup views
private extension SearchFilterViewController {
    func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(segmentControl)
        view.addSubview(container)

        addChild(pageController)
        container.addSubview(pageController.view)
    }

    func activateConstraints() {
        segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        container.topAnchor.constraint(equalTo: segmentControl.bottomAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        pageController.view.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        pageController.view.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        pageController.view.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        pageController.view.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
    }

    func configureNavBar() {
        title = "Filter todo"
    }
}
