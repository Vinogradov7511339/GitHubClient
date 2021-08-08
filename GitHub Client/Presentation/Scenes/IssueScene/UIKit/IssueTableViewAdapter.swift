//
//  IssueTableViewAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import UIKit

protocol IssueTableViewAdapter: UITableViewDataSource {}

final class IssueTableViewAdapterImpl: NSObject {
    private let issue: Issue

    init(issue: Issue) {
        self.issue = issue
    }
}

// MARK: - IssueTableViewAdapter
extension IssueTableViewAdapterImpl: IssueTableViewAdapter {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
