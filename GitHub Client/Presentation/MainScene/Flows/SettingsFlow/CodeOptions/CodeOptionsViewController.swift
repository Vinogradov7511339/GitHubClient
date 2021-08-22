//
//  CodeOptionsViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.08.2021.
//

import UIKit

final class CodeOptionsViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.allowsSelection = false
        tableView.dataSource = self
        return tableView
    }()

    private let codeOptions = SettingsStorageImpl.shared.codeOptions
    private let optionCellManager = TableCellManager.create(cellType: CodeOptionCell.self)
    private let codeCellManager = TableCellManager.create(cellType: CodePreviewCell.self)

    private var viewModels: [CodeOptionCellViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        configureNavBar()

        optionCellManager.register(tableView: tableView)
        codeCellManager.register(tableView: tableView)

        let showLineNumbers = CodeOptionCellViewModel(type: .showLineNumbers(codeOptions))
        let forceDarkMode = CodeOptionCellViewModel(type: .forceDarkMode(codeOptions))
        let lineWrrapping = CodeOptionCellViewModel(type: .lineWrapping(codeOptions))
        viewModels = [showLineNumbers, forceDarkMode, lineWrrapping]

        codeOptions.showLineNumbers.observe(on: self) { [weak self] _ in self?.updateSettings() }
        codeOptions.forceDarkMode.observe(on: self) { [weak self] _ in self?.updateSettings() }
        codeOptions.lineWrapping.observe(on: self) { [weak self] _ in self?.updateSettings() }
        tableView.reloadData()
    }

    func updateSettings() {
        tableView.reloadSections([1], with: .fade)
    }

    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension CodeOptionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? viewModels.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let option = viewModels[indexPath.row]
            let cell = optionCellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
            cell.populate(viewModel: option)
            return cell
        }
        let cell = codeCellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        let model = CodePreviewCellViewModel(codeOptions: codeOptions, code: Const.previewCode)
        cell.populate(viewModel: model)
        return cell
    }
}

// MARK: - Setup options
private extension CodeOptionsViewController {
//    func setupOptions() {
//        let lineWrapping = CodeOptionCellViewModel(
//            optionName: "Line Wrapping",
//            switchState: settingsStorage.codeOptions.value.lineWrapping,
//            switchHandler: updateLineWrappingState)
//
//        viewModels.append(lineWrapping)
//    }
}

// MARK: - Setup views
private extension CodeOptionsViewController {
    func setupViews() {
        view.addSubview(tableView)
    }

    func activateConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }

    func configureNavBar() {
        if navigationController?.viewControllers.count == 1 {
            let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(close))
            navigationItem.rightBarButtonItem = done
        }
    }
}

// MARK: - Constants
private extension CodeOptionsViewController {
    enum Const {
        static let previewCode: String = """
            // MARK: - Setup views
            private extension CodeOptionsViewController {
                func setupViews() {
                    view.addSubview(tableView)
                }

                func activateConstraints() {
                    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
                    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
                    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                }
            }
            """
    }
}
