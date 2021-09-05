//
//  UIColor+hex.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 24.07.2021.
//

import UIKit

extension UIColor {

    public convenience init?(hex: String, alpha: CGFloat) {
        var hex = hex
        if !hex.hasPrefix("#") {
            hex.insert("#", at: hex.startIndex)
        }

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
