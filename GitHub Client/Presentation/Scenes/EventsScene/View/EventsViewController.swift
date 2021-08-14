//
//  NotificationsViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

class EventsViewController: UIViewController {

    class TempLayout: UICollectionViewFlowLayout {

        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            let layoutAttributesObjects = super.layoutAttributesForElements(in: rect)?.map{ $0.copy() } as? [UICollectionViewLayoutAttributes]
            layoutAttributesObjects?.forEach({ layoutAttributes in
                if layoutAttributes.representedElementCategory == .cell {
                    if let newFrame = layoutAttributesForItem(at: layoutAttributes.indexPath)?.frame {
                        layoutAttributes.frame = newFrame
                    }
                }
            })
            return layoutAttributesObjects
        }

        override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
            guard let collectionView = collectionView else { return nil }
            guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else {
                return nil
            }

            layoutAttributes.frame.origin.x = sectionInset.left
            layoutAttributes.frame.size.width = collectionView.safeAreaLayoutGuide.layoutFrame.width - sectionInset.left - sectionInset.right
            return layoutAttributes
        }
    }

    private var viewModel: EventsViewModel!
    private lazy var adapter: EventsAdapter = {
        EventsAdapterImpl()
    }()

    private lazy var layout: TempLayout = {
        let layout = TempLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 8.0, right: 16.0)
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        collectionView.dataSource = adapter
        return collectionView
    }()

    static func create(with viewModel: EventsViewModel) -> EventsViewController {
        let viewController = EventsViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        title = "Events"
        navigationController?.navigationBar.prefersLargeTitles = false
        let image = UIImage(named: "filter_24pt")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(filterTapped))
        navigationItem.rightBarButtonItem = button

        adapter.register(collectionView: collectionView)
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    @objc func filterTapped() {
        let viewController = EventsFilterViewController()
        viewController.delegate = self
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true, completion: nil)
    }
}

// MARK: - Binding
private extension EventsViewController {
    func bind(to viewModel: EventsViewModel) {
        viewModel.events.observe(on: self) { [weak self] in self?.updateItems($0) }
    }

    func updateItems(_ events: [Event]) {
        adapter.update(events)
        collectionView.reloadData()
    }
}

extension EventsViewController: EventsFilterDelegate {
    func applyFilters(types: [EventFilterType]) {
        viewModel.apply(filters: types)
    }
}

// MARK: - UICollectionViewDelegate
extension EventsViewController: UICollectionViewDelegate {

}

private extension EventsViewController {
    func setupViews() {
        view.addSubview(collectionView)
    }

    func activateConstraints() {
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}
