//
//  ProfileViewControllerV2.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.08.2021.
//

import UIKit

final class ProfileViewControllerV2: UIViewController {

    static func create(with viewModel: ProfileViewModel) -> ProfileViewControllerV2 {
        let viewController = ProfileViewControllerV2()
        viewController.viewModel = viewModel
        return viewController
    }

    private var viewModel: ProfileViewModel!

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()

    private var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGroupedBackground
        return view
    }()

    private lazy var avatarImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.cornerRadius = 32.0
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var userBioStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var userInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        return stackView
    }()

    private lazy var eventsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("Last events", comment: "")
        label.font = .boldSystemFont(ofSize: 18.0)
        return label
    }()

    private lazy var showAllEventsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show all", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(openEvents), for: .touchUpInside)
        return button
    }()

    private lazy var eventsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        activateConstraints()

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}

// MARK: - Actions
private extension ProfileViewControllerV2 {
    @objc func openRepositories() {
        viewModel.openRepositories()
    }
    @objc func openFollowing() {
        viewModel.showFollowing()
    }
    @objc func openFollowers() {
        viewModel.showFollowers()
    }
    @objc func openStarred() {
        viewModel.openStarred()
    }

    @objc func openEvents() {

    }
}

// MARK: - Binding
private extension ProfileViewControllerV2 {
    func bind(to viewModel: ProfileViewModel) {
        viewModel.user.observe(on: self) { [weak self] in self?.updateScreen($0) }
        viewModel.events.observe(on: self) { [weak self] in self?.setupEventsStackView($0) }
    }

    func updateScreen(_ user: UserDetails?) {
        guard let user = user else { return }
        avatarImageView.set(url: user.user.avatarUrl)
        setupUserBioStackView(with: user)
        setupUserInfoStackView(with: user)
    }
}

private extension ProfileViewControllerV2 {
    func setupUserBioStackView(with user: UserDetails) {
        userBioStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        if let name = user.user.name {
            let nameLabel = UILabel()
            nameLabel.font = .boldSystemFont(ofSize: 18.0)
            nameLabel.text = name
            userBioStackView.addArrangedSubview(nameLabel)
        }

        let loginLabel = UILabel()
        loginLabel.text = user.user.login
        loginLabel.textColor = .secondaryLabel
        userBioStackView.addArrangedSubview(loginLabel)

        if let email = user.userEmail {
            addEmail(email)
        }

        if let company = user.company {
            addCompany(company)
        }
    }

    func addEmail(_ email: String) {
        let image = UIImage(systemName: "mail")?.withTintColor(.secondaryLabel)
        let attachment = NSTextAttachment(image: image!)
        let attributedStr = NSMutableAttributedString(attachment: attachment)
        let emailStr = NSAttributedString(string: email)
        attributedStr.append(emailStr)

        let emailLabel = UILabel()
        emailLabel.tintColor = .secondaryLabel
        emailLabel.attributedText = attributedStr
        userBioStackView.addArrangedSubview(emailLabel)
    }

    func addCompany(_ company: String) {
        let image = UIImage(systemName: "building.2")?.withTintColor(.secondaryLabel)
        let attachment = NSTextAttachment(image: image!)
        let attributedStr = NSMutableAttributedString(attachment: attachment)
        let companyStr = NSAttributedString(string: company)
        attributedStr.append(companyStr)

        let companyLabel = UILabel()
        companyLabel.attributedText = attributedStr
        userBioStackView.addArrangedSubview(companyLabel)
    }

    func setupUserInfoStackView(with user: UserDetails) {
        userInfoStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        addUserInfoItem(name: "repositories", count: user.repositoriesCount, selector: #selector(openRepositories))
        addUserInfoItem(name: "followers", count: user.followersCount, selector: #selector(openFollowers))
        addUserInfoItem(name: "following", count: user.followingCount, selector: #selector(openFollowing))
        addUserInfoItem(name: "starred", count: -1, selector: #selector(openStarred))
    }

    func addUserInfoItem(name: String, count: Int, selector: Selector) {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center

        let countButton = UIButton()
        countButton.addTarget(self, action: selector, for: .touchUpInside)
        countButton.setTitle("\(count)", for: .normal)
        countButton.setTitleColor(.label, for: .normal)
        countButton.titleLabel?.font = .boldSystemFont(ofSize: 24.0)
        stackView.addArrangedSubview(countButton)

        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.textColor = .secondaryLabel
        nameLabel.font = .systemFont(ofSize: 14.0)
        stackView.addArrangedSubview(nameLabel)

        userInfoStackView.addArrangedSubview(stackView)
    }

    func setupEventsStackView(_ events: [Event]) {
        eventsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for event in events {
            let eventView = ProfileEventView.create(with: event)
            eventsStackView.addArrangedSubview(eventView)
        }
    }

    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(headerView)
        headerView.addSubview(avatarImageView)
        headerView.addSubview(userBioStackView)
        scrollView.addSubview(userInfoStackView)
        scrollView.addSubview(eventsLabel)
        scrollView.addSubview(showAllEventsButton)
        scrollView.addSubview(eventsStackView)
    }

    func activateConstraints() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        headerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        avatarImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 32.0).isActive = true
        avatarImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 64.0).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 64.0).isActive = true

        userBioStackView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16.0).isActive = true
        userBioStackView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        userBioStackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -16.0).isActive = true

        userInfoStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16.0).isActive = true
        userInfoStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.0).isActive = true
        userInfoStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.0).isActive = true

        eventsLabel.topAnchor.constraint(equalTo: userInfoStackView.bottomAnchor, constant: 8.0).isActive = true
        eventsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.0).isActive = true

        showAllEventsButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.0).isActive = true
        showAllEventsButton.centerYAnchor.constraint(equalTo: eventsLabel.centerYAnchor).isActive = true

        eventsStackView.topAnchor.constraint(equalTo: eventsLabel.bottomAnchor, constant: 8.0).isActive = true
        eventsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8.0).isActive = true
        eventsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8.0).isActive = true
        eventsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
}
