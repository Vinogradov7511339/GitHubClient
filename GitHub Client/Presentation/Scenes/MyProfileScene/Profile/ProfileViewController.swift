//
//  ProfileViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.07.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    private var viewModel: ProfileViewModel!

    static func create(with viewModel: ProfileViewModel) -> ProfileViewController {
        let viewController = ProfileViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    private lazy var headerView: MyProfileHeaderView = {
        let view = MyProfileHeaderView.instanceFromNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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

    let maxHeaderHeight: CGFloat = 220.0
    let minHeaderHeight: CGFloat = 70.0
    var previousScrollOffset: CGFloat = 0
    var headerViewHeight: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        viewModel.cellManager.register(tableView: tableView)

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    @objc func refresh(_ sender: AnyObject) {
        viewModel.refresh()
    }

    @objc func openSettings(_ sender: AnyObject) {
        let settingController = SettingsGeneralViewController()
        navigationController?.pushViewController(settingController, animated: true)
    }

    @objc func share(_ sender: AnyObject) {
        viewModel.share()
    }
}

// MARK: - Binding
private extension ProfileViewController {
    func bind(to viewModel: ProfileViewModel) {
        viewModel.user.observe(on: self) { [weak self] in self?.update(user: $0)}
    }

    func update(user: User?) {
        guard let user = user else { return }
        headerView.setProfile(user)
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemGroupedBackground
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let headerViewHeight = headerViewHeight else { return }
        let scrollDiff = (scrollView.contentOffset.y - previousScrollOffset)
        let isScrollingDown = scrollDiff > 0
        let isScrollingUp = scrollDiff < 0
//        if canAnimateHeader(scrollView) {
            var newHeight = headerViewHeight.constant
            if isScrollingDown {
                newHeight = max(minHeaderHeight, headerViewHeight.constant - abs(scrollDiff))
            } else if isScrollingUp {
                newHeight = min(maxHeaderHeight, headerViewHeight.constant + abs(scrollDiff))
            }
            if newHeight != headerViewHeight.constant {
                headerViewHeight.constant = newHeight
                let percent = (newHeight - minHeaderHeight) / (maxHeaderHeight - minHeaderHeight)
                headerView.updateHeight(percent)
                setScrollPosition()
                previousScrollOffset = scrollView.contentOffset.y
            }
//        }
    }

    func canAnimateHeader (_ scrollView: UIScrollView) -> Bool {
        let scrollViewMaxHeight = scrollView.frame.height + self.headerViewHeight!.constant - minHeaderHeight
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    func setScrollPosition() {
        self.tableView.contentOffset = CGPoint(x: 0, y: 0)
    }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableItems.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableItem = viewModel.tableItems.value[indexPath.row]
        let cell = viewModel.cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: tableItem)
        return cell
    }
}

// MARK: - setup views
private extension ProfileViewController {
    func setupViews() {
        view.addSubview(tableView)
        view.addSubview(headerView)
    }

    func activateConstraints() {
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerViewHeight = headerView.heightAnchor.constraint(equalToConstant: 220)
        headerViewHeight?.isActive = true

        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
