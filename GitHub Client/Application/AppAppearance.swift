//
//  AppAppearance.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import UIKit

final class AppAppearance {

    static func setupAppearance() {
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:
                                                                UIColor.white]
    }
}

extension UINavigationController {
    @objc override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

enum Theme: Int, CaseIterable {
    case `default` = 0
    case dark = 1
    case graphical = 2

    var name: String {
        switch self {
        case .default: return NSLocalizedString("Default", comment: "")
        case .dark: return NSLocalizedString("Dark", comment: "")
        case .graphical: return NSLocalizedString("Graphical", comment: "")
        }
    }

    var barStyle: UIBarStyle {
        switch self {
        case .default, .graphical:
            return .default
        case .dark:
            return .black
        }
    }

    private enum Keys {
        static let selectedTheme = "SelectedTheme"
    }

    static var current: Theme {
        let storedTheme = UserDefaults.standard.integer(forKey: Keys.selectedTheme)
        return Theme(rawValue: storedTheme) ?? .default
    }

    var mainColor: UIColor {
        switch self {
        case .default:
            return UIColor(red: 87.0/255.0, green: 188.0/255.0, blue: 95.0/255.0, alpha: 1.0)
        case .dark:
            return UIColor(red: 255.0/255.0, green: 115.0/255.0, blue: 50.0/255.0, alpha: 1.0)
        case .graphical:
            return UIColor(red: 10.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 1.0)
        }
    }

    func apply(to window: UIWindow?) {
        window?.tintColor = mainColor
        UINavigationBar.appearance().barStyle = barStyle
        UITabBar.appearance().barStyle = barStyle
        UserDefaults.standard.set(rawValue, forKey: Keys.selectedTheme)
        window?.subviews.forEach { view in
            view.removeFromSuperview()
            window?.addSubview(view)
        }
    }
}
