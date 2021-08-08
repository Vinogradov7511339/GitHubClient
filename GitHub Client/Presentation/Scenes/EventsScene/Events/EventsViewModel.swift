//
//  EventsViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

struct EventsActions {}

protocol EventsViewModelInput {
    func viewDidLoad()
}

protocol EventsViewModelOutput {
    var cellManager: TableCellManager { get }
    var events: Observable<[BaseEventCellViewModel]> { get }
}

typealias EventsViewModel = EventsViewModelInput & EventsViewModelOutput

final class EventsViewModelImpl: EventsViewModel {

    // MARK: - Output
    var events: Observable<[BaseEventCellViewModel]> = Observable([])
    let cellManager: TableCellManager

    // MARK: - Private

    private let useCase: EventsUseCase
    private let actions: EventsActions

    private var currentPage = 1
    private var lastPage: Int?

    init(useCase: EventsUseCase, actions: EventsActions) {
        self.useCase = useCase
        self.actions = actions
        cellManager = TableCellManager.create(cellType: BaseEventTableViewCell.self)
    }
}

// MARK: - Input
extension EventsViewModelImpl {
    func viewDidLoad() {
        fetch()
    }
}

private extension EventsViewModelImpl {
    func fetch() {
        let model = EventsRequestModel(page: currentPage)
        useCase.fetchEvents(requestModel: model) { result in
            switch result {
            case .success(let model):
                let newItems = model.events
                let viewModels = newItems.map { BaseEventCellViewModel(eventType: $0.eventType.rawValue) }
                self.events.value.append(contentsOf: viewModels)
            case .failure(let error):
                self.handle(error: error)
            }
        }
    }

    func handle(error: Error) {

    }
}
