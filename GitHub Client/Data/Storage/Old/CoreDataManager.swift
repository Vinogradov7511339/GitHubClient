//
//  CoreDataManager.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.07.2021.
//

import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()

    lazy var rootObjectContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }()

    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("\(Self.modelName).sqlite")
        let options: [AnyHashable: Any] = [
            NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true,
            ]

        let storeDescription = NSPersistentStoreDescription(url: url!)
        coordinator.addPersistentStore(with: storeDescription) { storeDescription, error in
            print("aaa")
        }
        return coordinator
    }()

    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: Self.modelName, withExtension: "momd") else {
            fatalError("CoreDataManager Unable to Find Data Model")
        }

        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("CoreDataManager Unable to Load Data Model")
        }

        return managedObjectModel
    }()

    private static let modelName = "Model"

    func saveRootContext(completion: (() -> Void)? = nil) {
        rootObjectContext.perform {
            try? self.rootObjectContext.save()
//            completion()
        }
    }

    func getBackgroundContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = rootObjectContext
        return context
    }

    func entityForName(entityName: String, context: NSManagedObjectContext) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context)!
    }
}
