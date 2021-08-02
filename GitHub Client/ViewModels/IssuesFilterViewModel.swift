//
//  IssuesFilterViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 01.08.2021.
//

import UIKit

class IssuesFilterViewModel {
    enum FilterType: String, CaseIterable {
        case filter
        case state
        case sort
        case direction
    }

    weak var listener: FilterViewModelListener?
    weak var output: FilterViewModelOutput?

    private var model: IssuesFilters

    init(issueParams: IssuesFilters) {
        self.model = issueParams
    }

    func createMenu(for type: FilterType) -> UIMenu {
        let selectedItem = selectedItem(for: type)
        var items: [UIAction] = []

        for parameter in allParameters(for: type) {
            let identifer = identifier(type, item: parameter)
            let isSelected = selectedItem == parameter
            let item = menuItem(identifier: identifer,
                                item: parameter,
                                isSelected: isSelected,
                                handler: handler(action:)
            )
            items.append(item)
        }

        return UIMenu(children: items)
    }

    func identifier(_ type: FilterType, item: String) -> UIAction.Identifier {
        let identifier = type.rawValue + "." + item
        return UIAction.Identifier(identifier)
    }

    func menuItem(identifier: UIAction.Identifier,
                  item: String,
                  isSelected: Bool,
                  handler: @escaping (UIAction) -> Void) -> UIAction {
        let state: UIAction.State = isSelected ? .on : .off
        return UIAction(title: item, identifier: identifier, state: state, handler: handler)
    }

    func handler(action: UIAction) {
        let splitIdentifier = action.identifier.rawValue.split(separator: ".")
        guard splitIdentifier.count == 2 else {
            assert(false, "identifer counts: \(splitIdentifier.count)")
            return
        }

        guard let type = FilterType(rawValue: String(splitIdentifier[0])) else {
            assert(false, "can't init with type: \(String(splitIdentifier[0]))")
            return
        }

        let value = String(splitIdentifier[1])
        set(value: value, for: type)

        let index = index(of: type)
        let title = title(for: type)
        let menu = createMenu(for: type)
        let button = configureButton(with: title, menu: menu)

        output?.update(button: button, at: index)
        listener?.filterDidUpdated(object: model)
    }

    func configureButton(with title: String, menu: UIMenu) -> UIButton {
        let filterButton = FilterButton()
        filterButton.setTitle(title, for: .normal)
        filterButton.menu = menu
        filterButton.showsMenuAsPrimaryAction = true
        return filterButton
    }

}
extension IssuesFilterViewModel: FilterViewModel {

    var filterButtons: [UIButton] {
        createButtons()
    }
}

private extension IssuesFilterViewModel {
    func createButtons() -> [UIButton] {
        var buttons: [UIButton] = []
        for type in FilterType.allCases {
            let title = title(for: type)
            let menu = createMenu(for: type)
            let button = configureButton(with: title, menu: menu)
            buttons.append(button)
        }
        return buttons
    }
}

extension IssuesFilterViewModel {
    func index(of type: FilterType) -> Int {
        switch type {
        case .filter: return 0
        case .state: return 1
        case .sort: return 2
        case .direction: return 3
        }
    }

    func allParameters(for type: FilterType) -> [String] {
        switch type {
        case .filter: return ["assigned", "created", "mentioned", "subscribed", "all"]
        case .state: return ["open", "closed", "all"]
        case .sort: return ["created", "updated", "comments"]
        case .direction: return ["asc", "desc"]
        }
    }

    func selectedItem(for type: FilterType) -> String {
        switch type {
        case .filter: return model.filter
        case .state: return model.state
        case .sort: return model.sort
        case .direction: return model.direction
        }
    }

    func set(value: String, for type: FilterType) {
        switch type {
        case .filter: model.filter = value
        case .state: model.state = value
        case .sort: model.sort = value
        case .direction: model.direction = value
        }
    }

    func title(for type: FilterType) -> String {
        switch type {
        case .filter: return "type: \(model.filter)"
        case .state: return "state: \(model.state)"
        case .sort: return "sort: \(model.sort)"
        case .direction: return "direction: \(model.direction)"
        }
    }
}
