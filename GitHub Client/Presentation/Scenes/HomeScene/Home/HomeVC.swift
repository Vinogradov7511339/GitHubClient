//
//  HomeVC.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 15.08.2021.
//

import UIKit

final class HomeVC: UIViewController {

    static func create(with viewModel: HomeViewModel) -> HomeVC {
        let viewController = HomeVC()
        viewController.viewModel = viewModel
        return viewController
    }

    private lazy var collectionView: UICollectionView = {
        let layoutFactory = CompositionalLayoutFactory()
        let layout = layoutFactory.layout
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        return collectionView
    }()

    private var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        configureNavBar()
    }
}

private extension HomeVC {
    func setupViews() {
        view.addSubview(collectionView)
    }

    func activateConstraints() {
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = NSLocalizedString("Home", comment: "")
    }
}
