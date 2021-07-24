//
//  ProfileMostPopularCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.07.2021.
//

import UIKit

struct ProfileMostPopularCellViewModel {
    let repositories: [Repository]
}

class ProfileMostPopularCell: BaseTableViewCell {
    
    private lazy var iconImageView: UIImageView = {
        let image = UIImage(systemName: "star")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .label
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        label.text = "Popular"
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 300,height: 100)
        layout.minimumInteritemSpacing = 8.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var repositories: [Repository] = []
    private typealias Cell = ProfilePopularRepositoryCollectionViewCell
    
    override func completeInit() {
        super.completeInit()
//        backgroundColor = UIColor.systemGroupedBackground
        setupViews()
        activateConstraints()
        
        let nib = UINib(nibName: ProfilePopularRepositoryCollectionViewCell.nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ProfilePopularRepositoryCollectionViewCell.reuseIdentifier)
    }
    
    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
        
        
    }
}

extension ProfileMostPopularCell: ConfigurableCell {
    func configure(viewModel: ProfileMostPopularCellViewModel) {
        repositories = viewModel.repositories
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension ProfileMostPopularCell: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension ProfileMostPopularCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return UICollectionViewCell(frame: .zero)
        }
        cell.configure(with: repositories[indexPath.row])
        return cell
    }
}

// MARK: - setup views & constraints
private extension ProfileMostPopularCell {
    func setupViews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(label)
        contentView.addSubview(collectionView)
    }
    
    func activateConstraints() {        
        iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
        iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14.0).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        
        label.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 6.0).isActive = true
        label.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8.0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28.0).isActive = true
    }
}
