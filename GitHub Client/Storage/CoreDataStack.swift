//
//  CoreDataStack.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.07.2021.
//

//import Foundation
import CoreData

class CoreDataStack {
    
    private lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
            print("Core Data stack has been initialized with description: \(storeDescription)")
        }
        return container
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("CoreDataStack error \(error), \(error.userInfo)")
        }
    }
    
    func saveUser(user: UserProfile) {
//        if let dbUser = NSEntityDescription.insertNewObject(forEntityName: "UserDBModel", into: managedContext) as? UserDBModel {
//            dbUser.login = user.login
//            try? managedContext.save()
//        }
    }
    
    func getUser() {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserDBModel")
//        let fetchUsers = try? managedContext.fetch(fetchRequest) as? [UserDBModel]
    }
}
