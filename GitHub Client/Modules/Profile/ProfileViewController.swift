//
//  ProfileViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.07.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var presenter: ProfilePresenterInput!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private let refreshControl = UIRefreshControl()
    
    private let dataViewMap: [String: TableCellManager] = [
        "\(UserProfile.self)": TableCellManager.create(cellType: ProfileHeaderTableViewCell.self),
        "\(ProfileMostPopularCellViewModel.self)": TableCellManager.create(cellType: ProfileMostPopularCell.self),
        "\(TableCellViewModel.self)": TableCellManager.create(cellType: TableViewCell.self)
    ]
    
    private var viewModels: [[Any]] = [[]]
    private var selectableSection = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        
        configureNavBar()
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        dataViewMap.forEach { $0.value.register(tableView: tableView) }
        presenter?.viewDidLoad()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        presenter?.refresh()
    }
    
    @objc func openSettings(_ sender: AnyObject) {
        let settingController = SettingsGeneralViewController()
        navigationController?.pushViewController(settingController, animated: true)
    }
    
    @objc func share(_ sender: AnyObject) {
        presenter.share()
    }
}

// MARK: - ProfilePresenterOutput
extension ProfileViewController: ProfilePresenterOutput {
    
    func showError(error: Error) {
        refreshControl.endRefreshing()
        print(error)
    }
    
    func push(to viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func display(viewModels: [[Any]]) {
        self.viewModels = viewModels
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath.section == selectableSection ? indexPath : nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectItem(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemGroupedBackground
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 20.0 : 0.0
    }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let viewModel = viewModels[indexPath.section][indexPath.row]
        
        guard let cellManager = cellManager(for: viewModel) else {
            assert(false, "unknown viewModel \(viewModel) at \(indexPath)")
            return UITableViewCell()
        }
        
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.selectionStyle = indexPath.section == selectableSection ? .default : .none
        if let cell = cell as? ProfileHeaderTableViewCell {
            cell.delegate = self
        }
        
        cell.populate(viewModel: viewModel)
        return cell
    }
}

// MARK: - ProfileHeaderTableViewCellDelegate
extension ProfileViewController: ProfileHeaderTableViewCellDelegate {
    func followersButtonTouchUpInside() {
        presenter?.openFollowers()
    }
    
    func followingButtonTouchUpInside() {
        presenter?.openFollowing()
    }
    
    func linkButtonTouchUpInside() {
        presenter?.openLink()
    }
    
    func mailButtonTouchUpInside() {
        presenter?.openSendMail()
    }
}

// MARK: - private
private extension ProfileViewController {
    func cellManager(for viewModel: Any) -> TableCellManager? {
        let key = "\(type(of: viewModel))"
        let cellManager = dataViewMap[key]
        return cellManager
    }
}

// MARK: - setup views
private extension ProfileViewController {
    func setupViews() {
        view.addSubview(tableView)
    }

    func activateConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureNavBar() {
        switch presenter.type {
        case .myProfile:
            let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(self.openSettings(_:)))
            self.navigationItem.rightBarButtonItem  = settingsButton
        case .notMyProfile(_):
            let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(self.share(_:)))
            self.navigationItem.rightBarButtonItem  = shareButton
        }
    }
}
