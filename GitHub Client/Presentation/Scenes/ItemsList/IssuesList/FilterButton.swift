//
//  FilterButton.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 01.08.2021.
//

import UIKit

class FilterButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        setTitleColor(.secondaryLabel, for: .normal)
        tintColor = .secondaryLabel
        backgroundColor = .systemBackground
        borderColor = .placeholderText
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        let image = UIImage(systemName: "chevron.down")?
            .applyingSymbolConfiguration(.init(scale: .small))
        setImage(image, for: .normal)
        contentEdgeInsets = UIEdgeInsets(top: 4.0, left: 8.0, bottom: 4.0, right: 8.0)
        semanticContentAttribute = .forceRightToLeft
        cornerRadius = intrinsicContentSize.height / 2.0
    }
}
