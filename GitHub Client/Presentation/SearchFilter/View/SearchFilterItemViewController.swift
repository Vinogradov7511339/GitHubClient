//
//  SearchFilterItemViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.08.2021.
//

import UIKit


final class SearchFilterItemViewController: UIViewController {

    // MARK: - Create

    static func create(with filter: SearchFilter,
                       type: SearchFilter.FilterType) -> SearchFilterItemViewController {
        let viewController = SearchFilterItemViewController()
        viewController.filter = filter
        viewController.filterType = type
        return viewController
    }

    // MARK: - Views

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8.0
        return stackView
    }()

    // MARK: - Private variables

    var filter: SearchFilter!
    var filterType: SearchFilter.FilterType!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        fillStackView()
        updateStackView()
//        switch filterType {
//        case .repositories:
//            view.backgroundColor = .red
//        case .issues:
//            view.backgroundColor = .green
//        case .pullRequests:
//            view.backgroundColor = .blue
//        case .people:
//            view.backgroundColor = .yellow
//        case .none:
//            break
//        }
    }
}

// MARK: - Setup views
private extension SearchFilterItemViewController {
    func setupViews() {
        view.addSubview(stackView)
    }

    func activateConstraints() {
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16.0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func fillStackView() {
        let itemsCount: Int
        switch filterType {
        case .repositories:
            itemsCount = SearchFilter.RepositoriesSearchParameters.allCases.count
        case .issues:
            itemsCount = SearchFilter.IssuesSearchParameters.allCases.count
        case .pullRequests:
            itemsCount = SearchFilter.PullReqestsSearchParameters.allCases.count
        case .people:
            itemsCount = SearchFilter.UsersSearchParameters.allCases.count
        case .none:
            itemsCount = 0
        }
        for _ in 0..<itemsCount {
            addItem()
        }
    }

    func addItem() {
        let item = FilterItemView()
        stackView.addArrangedSubview(item)
        item.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    }

    func updateStackView() {
        let titles: [String]
        let selectedIndex: Int
        switch filterType {
        case .repositories:
            titles = SearchFilter.RepositoriesSearchParameters.allCases.map { $0.rawValue }
            selectedIndex = titles.firstIndex(
                where: { $0 == filter.repositoriesSearchParameters.rawValue }) ?? 0

        case .issues:
            titles = SearchFilter.IssuesSearchParameters.allCases.map { $0.rawValue }
            selectedIndex = titles.firstIndex(
                where: { $0 == filter.issuesSearchParameters.rawValue }) ?? 0

        case .pullRequests:
            titles = SearchFilter.PullReqestsSearchParameters.allCases.map { $0.rawValue }
            selectedIndex = titles.firstIndex(
                where: { $0 == filter.pullReqestsSearchParameters.rawValue }) ?? 0

        case .people:
            titles = SearchFilter.UsersSearchParameters.allCases.map { $0.rawValue }
            selectedIndex = titles.firstIndex(
                where: { $0 == filter.usersSearchParameters.rawValue }) ?? 0

        case .none:
            titles = []
            selectedIndex = 0
        }
        for (index, title) in titles.enumerated() {
            if let itemView = stackView.arrangedSubviews[index] as? FilterItemView {
                itemView.setState(title, isSelected: index == selectedIndex, action: updateFilter(_:))
            }
        }
    }

    func updateFilter(_ name: String?) {
        guard let name = name else {
            assert(false, "no name")
            return
        }
        switch filterType {
        case .repositories:
            filter.repositoriesSearchParameters = SearchFilter.RepositoriesSearchParameters.init(rawValue: name) ?? .all
        case .issues:
            filter.issuesSearchParameters = SearchFilter.IssuesSearchParameters.init(rawValue: name) ?? .all
        case .pullRequests:
            filter.pullReqestsSearchParameters = SearchFilter.PullReqestsSearchParameters.init(rawValue: name) ?? .all
        case .people:
            filter.usersSearchParameters = SearchFilter.UsersSearchParameters.init(rawValue: name) ?? .all
        case .none:
            break
        }
        updateStackView()
    }
}

final class FilterItemView: UIView {

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var bgButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(itemTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        completeInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        completeInit()
    }

    var action: ((String?) -> Void)?

    private func completeInit() {
        cornerRadius = 8.0
        borderWidth = 1.0
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(bgButton)

        imageView.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4.0).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        bgButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bgButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bgButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bgButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    @objc func itemTapped() {
        action?(titleLabel.text)
    }

    func setState(_ title: String, isSelected: Bool, action: @escaping (String?) -> Void) {
        self.action = action
        titleLabel.text = title
        if isSelected {
            titleLabel.textColor = .label
        } else {
            titleLabel.textColor = .secondaryLabel
        }
        let imageName = isSelected ? "selected_circle" : "empty_circle"
        let image = UIImage(named: imageName)
        let color: UIColor? = isSelected ? .link : .opaqueSeparator.withAlphaComponent(0.5)
        UIView.transition(with: imageView,
                          duration: 0.5,
                          options: .curveEaseIn) {
            self.imageView.image = image
            self.imageView.tintColor = color
            self.borderColor = color
        } completion: { _ in}
    }
}
