//
//  HomeVC.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 15.08.2021.
//

import UIKit

final class HomeVC: UIViewController {

    static let sectionHeaderElementKind = "section-header-element-kind"

    static func create(with viewModel: HomeViewModel) -> HomeVC {
        let viewController = HomeVC()
        viewController.viewModel = viewModel
        return viewController
    }

    private lazy var adapter: HomeAdapter = {
        let adapter = HomeAdapterImpl()
        return adapter
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = HomeFlowLayout().layout
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        collectionView.dataSource = adapter
        collectionView.register(WidgetsHeaderView.self,
                                forSupplementaryViewOfKind: HomeVC.sectionHeaderElementKind,
                                withReuseIdentifier: WidgetsHeaderView.reuseIdentifier)
        return collectionView
    }()

    private var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        configureNavBar()
        adapter.register(collectionView)

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

// MARK: - Binding
private extension HomeVC {
    func bind(to viewModel: HomeViewModel) {
        viewModel.widgets.observe(on: self) { [weak self] in self?.updateWidgets($0) }
    }

    func updateWidgets(_ widgets: [HomeWidget]) {
        adapter.update(widgets)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
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
