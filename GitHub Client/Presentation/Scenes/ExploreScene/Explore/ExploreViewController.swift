//
//  ExploreViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

class ExploreViewController: UIViewController {
    
    var presenter: ExplorePresenter!
    
    private lazy var collectionView: UICollectionView = {
        let layout = presenter.layout
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        collectionView.dataSource = presenter
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        
        title = "Explore"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        presenter.dataViewMap.values.forEach { $0.register(collectionView: collectionView) }
        
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
}

// MARK: - ExplorePresenterOutput
extension ExploreViewController: ExplorePresenterOutput {
    func reloadData() {
        collectionView.reloadData()
    }
    
    func push(to viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegate
extension ExploreViewController: UICollectionViewDelegate {
    
}

// MARK: - setup views
private extension ExploreViewController {
    func setupViews() {
        view.addSubview(collectionView)
    }

    func activateConstraints() {
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
