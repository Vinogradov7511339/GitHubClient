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

    private let optionCellManager = TableCellManager.create(cellType: CodeOptionCell.self)
    private let codeCellManager = TableCellManager.create(cellType: CodePreviewCell.self)

    private var options: [CodeOptionCellViewModel] = []
    private var currentCodeOptions: CodeOptions = CodeOptions(lineWrapping: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        optionCellManager.register(tableView: tableView)
        codeCellManager.register(tableView: tableView)

        setupOptions()
        tableView.reloadData()
    }

    func updateLineWrappingState(_ newState: Bool) {
        let newOptions = CodeOptions(lineWrapping: newState)
        currentCodeOptions = newOptions
        tableView.reloadSections([1], with: .fade)
    }
}

// MARK: - UITableViewDataSource
extension CodeOptionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? options.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let option = options[indexPath.row]
            let cell = optionCellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
            cell.populate(viewModel: option)
            return cell
        }
        let cell = codeCellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        let model = CodePreviewCellViewModel(codeOptions: currentCodeOptions, code: Const.previewCode)
        cell.populate(viewModel: model)
        return cell
    }
}

// MARK: - Setup options
private extension CodeOptionsViewController {
    func setupOptions() {
        let lineWrapping = CodeOptionCellViewModel(
            optionName: "Line Wrapping",
            switchState: false,
            switchHandler: updateLineWrappingState)

        options.append(lineWrapping)
    }
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
