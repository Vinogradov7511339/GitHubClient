//
//  FilterView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 31.07.2021.
//

import UIKit

class FilterView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: bounds)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        return stackView
    }()
    
    func configure(with filters: [[String]]) {
        for filter in filters {
            createFilter(with: filter)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        completeInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        completeInit()
    }
    
    private func completeInit() {
        setupViews()
        activateConstraints()
    }
}

private extension FilterView {
    func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    func activateConstraints() {
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.0).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func createFilter(with filter: [String]) {
        let filterButton = UIButton(type: .roundedRect)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.setTitle(filter[0], for: .normal)
        filterButton.setTitleColor(.secondaryLabel, for: .normal)
        filterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        
        let image = UIImage(systemName: "chevron.down")?
            .applyingSymbolConfiguration(.init(scale: .small))
        filterButton.setImage(image, for: .normal)
        filterButton.tintColor = .secondaryLabel
        
        filterButton.contentEdgeInsets = UIEdgeInsets(top: 4.0, left: 8.0, bottom: 4.0, right: 8.0)
        filterButton.semanticContentAttribute = .forceRightToLeft
        filterButton.cornerRadius = filterButton.intrinsicContentSize.height / 2.0
        filterButton.backgroundColor = .secondarySystemBackground
        filterButton.borderColor = .placeholderText
        
        stackView.addArrangedSubview(filterButton)
        filterButton.widthAnchor.constraint(equalToConstant: filterButton.intrinsicContentSize.width).isActive = true
    }
}
