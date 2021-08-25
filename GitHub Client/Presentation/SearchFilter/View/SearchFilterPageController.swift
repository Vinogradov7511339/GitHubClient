//
//  SearchFilterPageController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.08.2021.
//

import UIKit

final class SearchFilterPageController: UIPageViewController {

    // MARK: - Create

    static func create(with viewControllers: [UIViewController],
                       dataSource: UIPageViewControllerDataSource) -> SearchFilterPageController {
        let viewController = SearchFilterPageController(transitionStyle: .scroll,
                                                        navigationOrientation: .horizontal,
                                                        options: nil)
        viewController.childControllers = viewControllers
        viewController.dataSource = dataSource
        return viewController
    }

    // MARK: - Private variables

    private var childControllers: [UIViewController] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstViewController = childControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}
