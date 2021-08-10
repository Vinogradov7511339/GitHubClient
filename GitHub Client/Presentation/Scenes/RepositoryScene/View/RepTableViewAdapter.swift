//
//  RepTableViewAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import UIKit

protocol RepTableViewAdapter: UITableViewDataSource {}

final class RepTableViewAdapterImpl: NSObject {

    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }
}

// MARK: - RepTableViewAdapter
extension RepTableViewAdapterImpl: RepTableViewAdapter {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
