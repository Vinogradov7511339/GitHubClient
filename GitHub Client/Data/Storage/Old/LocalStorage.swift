//
//  LocalStorage.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.07.2021.
//

import CoreData

extension Notification.Name {
    enum Storage {
        static let didFail = Notification.Name(rawValue: "StorageDidFail")
        static let diskFull = Notification.Name(rawValue: "StorageDiskFull")
    }
}

class LocalStorage {
    
//    static let shared = LocalStorage()
    static let storageErrorKey = "LocalStorageError"
    
    private weak var lastOperation: Operation?
    private lazy var operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .userInitiated
        return queue
    }()

    func saveUser(user: UserDetailsResponseDTO) {
        performUpdate { [self] context in
            self.saveUser(user: user, in: context)
        }
    }

//    func getUser(completion: @escaping ([UserDBModel]) -> Void) {
//        performUpdate { context in
//            let users = self.getUsers(in: context)
//            completion(users)
//        }
//    }
}

private extension LocalStorage {

//    func getUsers(in context: NSManagedObjectContext) -> [UserDBModel] {
//        let fetchRequest: NSFetchRequest<UserDBModel> = UserDBModel.fetchRequest()
//        if let objects = try? context.fetch(fetchRequest) {
//            return objects
//        }
//        return []
//    }
//
//    func getUser(user: UserProfile, in context: NSManagedObjectContext) -> UserDBModel? {
//        let fetchRequest: NSFetchRequest<UserDBModel> = UserDBModel.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id == %id", user.id)
//
//        return try? context.fetch(fetchRequest).first
//    }

    func saveUser(user: UserDetailsResponseDTO, in context: NSManagedObjectContext) {
//        let dbUser = getOrCreateUser(user, in: context)
//        guard let dbUser = dbUser else { fatalError() }
//        UserProfileAdapter.toDBModel(dbUser, from: user)
//        dbUser.id = Int64(user.id)
//        dbUser.bio = user.bio
//        dbUser.blog = user.blog?.absoluteString
//        dbUser.email = user.email
//        dbUser.followers = user.followers_url.absoluteString
//        dbUser.following = user.following_url
//        dbUser.location = user.location
//        dbUser.image = nil
    
//        context.insert(dbUser)
    }

//    func getOrCreateUser(_ user: UserProfile, in context: NSManagedObjectContext) -> UserDBModel? {
//        let fetchRequest: NSFetchRequest<UserDBModel> = UserDBModel.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id == %id", user.id)
//        
//        if let objects = try? context.fetch(fetchRequest), let object = objects.first {
//            return object
//        }
//        return createUser(in: context)
//    }
//    
//    func createUser(in context: NSManagedObjectContext) -> UserDBModel? {
//        let userEntity = CoreDataManager.shared.entityForName(entityName: "UserDBModel", context: context)
//        let object = NSManagedObject(entity: userEntity, insertInto: context) as? UserDBModel
//        return object
//    }

    func saveContext(_ context: NSManagedObjectContext, completion: @escaping (Error?) -> Void) {
        guard context.hasChanges else {
            completion(nil)
            return
        }

        do {
            try context.save()
        } catch {
            completion(error)
            return
        }

        let rootContext = CoreDataManager.shared.rootObjectContext
        rootContext.performAndWait {
            do {
                try rootContext.save()
            } catch {
                completion(error)
                return
            }
            completion(nil)
        }
    }

    func performUpdate(updateAction: @escaping (NSManagedObjectContext) -> Void) {
        performUpdate(updateAction: updateAction, completion: {})
    }

    func performUpdate(updateAction: @escaping (NSManagedObjectContext) -> Void, completion: @escaping () -> Void) {
        let operation = AsyncOperation { operationCompletion in
            let context = CoreDataManager.shared.getBackgroundContext()
            context.perform {
                updateAction(context)
                self.saveContext(context) { error in
                    if let error = error {
                        DispatchQueue.main.async {
                            self.handleSaveError(error)
                        }
                    }
                    operationCompletion()
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            }
        }
        
        if let operation = lastOperation {
            operation.addDependency(operation)
        }
        
        lastOperation = operation
        operationQueue.addOperation(operation)
    }
    
    func handleSaveError(_ error: Error) {
        let nsError = error as NSError
        guard let sqlLiteError = nsError.userInfo[NSSQLiteErrorDomain] as? Int else {
            return
        }
        
        switch sqlLiteError {
        case SqlLiteErrors.sqliteFull:
            self.postDiskFullNotification()
            
        default:
            self.postFailNotification(error: error)
        }
    }
    
    func postDiskFullNotification() {
        NotificationCenter.default.post(
            name: Notification.Name.Storage.diskFull,
            object: nil,
            userInfo: nil)
    }
    
    func postFailNotification(error: Error) {
        let userInfo: [AnyHashable: Any] = [
            LocalStorage.storageErrorKey: error,
        ]
        
        NotificationCenter.default.post(
            name: Notification.Name.Storage.didFail,
            object: nil,
            userInfo: userInfo)
    }
}

// MARK: Constants
extension LocalStorage {
    private enum SqlLiteErrors {
        static let sqliteFull = 13
    }
}
