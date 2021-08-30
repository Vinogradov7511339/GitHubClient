//
//  UserActivityCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.08.2021.
//

import UIKit

class UserActivityCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var activityCollectionView: UICollectionView!

    private var events: [Event] = []
    private let cellManager = CollectionCellManager.create(cellType: UserActivityItemCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        activityCollectionView.showsHorizontalScrollIndicator = false
        activityCollectionView.dataSource = self
        activityCollectionView.delegate = self
        cellManager.register(collectionView: activityCollectionView)
    }

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension UserActivityCell: ConfigurableCell {
    func configure(viewModel: UserProfile) {
        self.events = viewModel.lastEvents
        activityCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension UserActivityCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        events.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cellManager.dequeueReusableCell(collectionView: collectionView, for: indexPath)
        cell.populate(viewModel: events[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension UserActivityCell: UICollectionViewDelegate {}
