//
//  UIColor+hex.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 24.07.2021.
//

import UIKit

extension UIColor {
    static func getLanguageColor(for language: String?) -> UIColor? {
        guard let language = language,
              let hex = ApplicationPresenter.shared.languageColorsDict[language] else {
            return nil
        }
        return UIColor(hex: hex, alpha: 1.0)
    }

    public convenience init?(hex: String, alpha: CGFloat) {
        guard hex.hasPrefix("#") else { return nil }

        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])
        guard hexColor.count == 6 else { return nil }

        let red, green, blue: CGFloat
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {
            red = CGFloat((hexNumber & 0xff0000) >> 16) / 255
            green = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
            blue = CGFloat((hexNumber & 0x0000ff) >> 0) / 255

            self.init(red: red, green: green, blue: blue, alpha: alpha)
            return
        }

        return nil
    }
}
