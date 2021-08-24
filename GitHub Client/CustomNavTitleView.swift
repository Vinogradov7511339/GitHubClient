//
//  CustomNavTitleView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 24.08.2021.
//

import UIKit

func setTitle(title:String, subtitle:String) -> UIView {
    let titleLabel = UILabel(frame: CGRect(x: 0, y: -2, width: 0, height: 0))

    titleLabel.backgroundColor = .clear
    titleLabel.textColor = .gray
//    titleLabel.font = UIFont.boldSystemFontOfSize(17)
    titleLabel.font = .boldSystemFont(ofSize: 17)
    titleLabel.text = title
    titleLabel.sizeToFit()

    let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 18, width: 0, height: 0))
    subtitleLabel.backgroundColor = .clear
    subtitleLabel.textColor = .black
//    subtitleLabel.font = UIFont.systemFontOfSize(12)
    subtitleLabel.font = .systemFont(ofSize: 12)
    subtitleLabel.text = subtitle
    subtitleLabel.sizeToFit()

    let titleView = UIView(frame: CGRect(x: 0, y: 0, width: max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), height: 30))
    titleView.addSubview(titleLabel)
    titleView.addSubview(subtitleLabel)

    let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width

    if widthDiff < 0 {
        let newX = widthDiff / 2
        subtitleLabel.frame.origin.x = abs(newX)
    } else {
        let newX = widthDiff / 2
        titleLabel.frame.origin.x = newX
    }

    return titleView
}
