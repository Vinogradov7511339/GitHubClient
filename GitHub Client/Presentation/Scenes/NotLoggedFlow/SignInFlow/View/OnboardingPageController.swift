//
//  OnboardingPageController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.07.2021.
//

import UIKit
import WebKit

struct IntroScene {
    var name: String
    var mainTitle: String
    var animationName: String
    let viewControllerName: String = "IntroductionViewController"
    let storyBoardName: String = "Main"
}

class OnboardingPageController: UIPageViewController {

    // MARK: - Create

    static func create(with controllers: [UIViewController]) -> OnboardingPageController {
        let viewController = OnboardingPageController(transitionStyle: .scroll,
                                                      navigationOrientation: .horizontal,
                                                      options: nil)
        viewController.childControllers = controllers
        return viewController
    }

    // MARK: - Private variables

    private let webView = WKWebView()
    private var childControllers: [UIViewController] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        configurePageControl()
        if let firstViewController = childControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingPageController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = childControllers.firstIndex(of: viewController) else {
            return nil
        }
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
        guard let firstViewController = viewControllers?.first,
              let firstViewControllerIndex = childControllers.firstIndex(of: firstViewController) else {
            return 0
        }

        return firstViewControllerIndex
    }
}

// MARK: - Setup views
private extension OnboardingPageController {
    func configurePageControl() {
        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [OnboardingPageController.self])
        appearance.currentPageIndicatorTintColor = .orange
        appearance.pageIndicatorTintColor = .gray
    }
}
