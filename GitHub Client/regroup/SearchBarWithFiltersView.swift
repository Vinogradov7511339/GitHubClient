//
//  SearchBarWithFiltersView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

class SearchBarWithFiltersView: UIView {

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    private lazy var filtersView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        completeInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        completeInit()
    }

    func completeInit() {
        setupViews()
        activateConstraints()
    }

    private func setupViews() {
        addSubview(searchBar)
        addSubview(filtersView)
    }

    private func activateConstraints() {
        searchBar.topAnchor.constraint(equalTo: topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50.0).isActive = true

        filtersView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        filtersView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        filtersView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        filtersView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
