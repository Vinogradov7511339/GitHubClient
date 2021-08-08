//
//  EventsSceneFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

protocol EventsSceneFactory {
    func makeEventsViewController(_ actions: EventsActions) -> EventsViewController
}

final class EventsSceneFactoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - EventsSceneFactory
extension EventsSceneFactoryImpl: EventsSceneFactory {
    func makeEventsViewController(_ actions: EventsActions) -> EventsViewController {
        .create(with: createEventsViewModel(actions: actions))
    }
}

private extension EventsSceneFactoryImpl {
    func createEventsViewModel(actions: EventsActions) -> EventsViewModel {
        EventsViewModelImpl(useCase: createEventsUseCase(), actions: actions)
    }

    func createEventsUseCase() -> EventsUseCase {
        EventsUseCaseImpl(repository: createEventsRepository())
    }

    func createEventsRepository() -> EventsRepository {
        EventsRepositoryImpl(dataTransferService: dataTransferService)
    }
}
