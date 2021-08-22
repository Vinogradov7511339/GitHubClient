//
//  EventsSceneDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

final class EventsSceneDIContainer {

    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }

    let dependencies: Dependencies

    private let eventsFactory: EventsSceneFactory

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.eventsFactory = EventsSceneFactoryImpl(dataTransferService: dependencies.apiDataTransferService)
    }

    func makeEventsViewController(_ actions: EventsActions) -> EventsViewController {
        eventsFactory.makeEventsViewController(actions)
    }
}
