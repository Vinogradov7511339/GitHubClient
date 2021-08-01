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
    
    func configure(with viewModel: FilterViewModel) {
        let buttons = viewModel.filterButtons
        buttons.forEach {
            stackView.addArrangedSubview($0)
            $0.widthAnchor.constraint(equalToConstant: $0.intrinsicContentSize.width).isActive = true
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

extension FilterView: FilterViewModelOutput {
    func update(button: UIButton, at index: Int) {
        guard let oldButton = stackView.arrangedSubviews[index] as? UIButton else { fatalError() }
        stackView.removeArrangedSubview(oldButton)
        oldButton.removeFromSuperview()
        stackView.insertArrangedSubview(button, at: index)
        button.widthAnchor.constraint(equalToConstant: button.intrinsicContentSize.width).isActive = true
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
}
