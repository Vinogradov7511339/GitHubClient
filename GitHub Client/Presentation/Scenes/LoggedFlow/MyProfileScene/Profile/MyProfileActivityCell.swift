//
//  MyProfileActivityCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.09.2021.
//

import UIKit

protocol MyProfileActivityCellDelegate: AnyObject {
    func linkTapped(_ url: URL)
}

class MyProfileActivityCell: BaseTableViewCell, NibLoadable {

    // MARK: - Delegate

    weak var delegate: MyProfileActivityCellDelegate?

    // MARK: - Views

    @IBOutlet weak var activityCollectionView: UICollectionView!

    // MARK: - Private

    private var events: [Event] = []
    private let cellManager = CollectionCellManager.create(cellType: MyProfileActivityItemCell.self)

    // MARK: - Lifecycle

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
extension MyProfileActivityCell: ConfigurableCell {
    func configure(viewModel: AuthenticatedUser) {
        self.events = viewModel.userDetails.lastEvents
        activityCollectionView.reloadData()
    }
}

//MARK: - MyProfileActivityItemCellDelegate
extension MyProfileActivityCell: MyProfileActivityItemCellDelegate {
    func linkTapped(_ url: URL) {
        delegate?.linkTapped(url)
    }
}

// MARK: - UICollectionViewDataSource
extension MyProfileActivityCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        events.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cellManager.dequeueReusableCell(collectionView: collectionView, for: indexPath)
        cell.populate(viewModel: events[indexPath.row])
        if let profileActivityCell = cell as? MyProfileActivityItemCell {
            profileActivityCell.delegate = self
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MyProfileActivityCell: UICollectionViewDelegate {}
