//
//  SearchController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.07.2021.
//

import UIKit

class SearchController: UISearchController {

    // Mark this property as lazy to defer initialization until
    // the searchBar property is called.
    private lazy var customSearchBar: SearchBar = {
        let searchBar = SearchBar(frame: view.frame)
        view.addSubview(searchBar)
        return searchBar
    }()

    // Override this property to return your custom implementation.
    override var searchBar: UISearchBar {
        customSearchBar
    }
    
    
}

class SearchBar: UISearchBar {
    
    private lazy var filterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    override var frame: CGRect {
        didSet {
            if frame.height == 52.0 {
                print("aaa")
            }
            if frame != oldValue {}
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let searchBarSize = super.sizeThatFits(size)
        let sizeWithFilter = CGSize(width: searchBarSize.width, height: searchBarSize.height + 100.0)
        return sizeWithFilter
        
//        super.sizeThatFits(size)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addSubview(filterView)
//        filterView.frame = CGRect(x: 0, y: frame.maxY - 100.0, width: frame.width, height: 100)
        filterView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor).isActive = true
        filterView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        filterView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        filterView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}

class NavigationController: UINavigationController {
    
}

class NavigationBar: UINavigationBar {
}
