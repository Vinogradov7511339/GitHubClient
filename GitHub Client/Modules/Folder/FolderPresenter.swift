//
//  FolderPresenter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

protocol FolderPresenterInput {
    var output: FolderPresenterOutput? { get set }

    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
}

protocol FolderPresenterOutput: AnyObject {
    func display(viewModels: [Any])
    func push(to viewController: UIViewController)
}

class FolderPresenter {
    var output: FolderPresenterOutput?
    
    private let service = ServicesManager.shared.repositoryService
    private let filePath: URL
    private var items: [DirectoryResponse] = []
    
    init(_ filePath: URL) {
        self.filePath = filePath
    }
}

// MARK: - FolderPresenterInput
extension FolderPresenter: FolderPresenterInput {
    func viewDidLoad() {
        fetchContent()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let item = items[indexPath.row]
        if item.type == "dir" {
            openFolder(filePath: item.url)
        } else if item.type == "file" {
            openFile(filePath: item.url)
        }
    }
}

// MARK: - private
private extension FolderPresenter {
    func fetchContent() {
        service.fetchContent(filePath: filePath) { items, error in
            if let items = items {
                self.items = items
                let mappedItems = items.map { self.map($0) }
                DispatchQueue.main.async {
                    self.output?.display(viewModels: mappedItems)
                }
            }
        }
    }
    
    func openFolder(filePath: URL) {
        let viewController = FolderConfigurator.create(from: filePath)
        output?.push(to: viewController)
    }
    
    func openFile(filePath: URL) {
        let viewController = FileConfigurator.create(from: filePath)
        output?.push(to: viewController)
    }
    
    func map(_ item: DirectoryResponse) -> TableCellViewModel {
        let iconName = item.type == "dir" ? "folder.fill" : "doc"
        let image = UIImage(systemName: iconName)
        return TableCellViewModel(
            text: item.name,
            detailText: nil,
            image: image,
            imageTintColor: nil,
            accessoryType: .disclosureIndicator
        )
    }
}
