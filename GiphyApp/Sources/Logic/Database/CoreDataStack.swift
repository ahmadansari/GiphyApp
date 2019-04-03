//
//  CoreDataStack.swift
//  GiphyApp
//
//  Created by Ahmad Ansari on 02/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let defaultStack = CoreDataStack()
    private var containerName: String!
        
    // Make init private for singleton
    private init() {
        configure(containerName: Constants.XCDataModelFile)
    }
    
    @objc func configure(containerName container: String) {
        containerName = container
        _ = persistentContainer
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        var container: NSPersistentContainer!
        if let model = NSManagedObjectModel.mergedModel(from: [Bundle.main]) {
            container = NSPersistentContainer(name: containerName, managedObjectModel: model)
            let storeDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
            let storeFileName = String(format: "%@.sqlite", containerName)
            let url = storeDirectory.appendingPathComponent(storeFileName)
            let description = NSPersistentStoreDescription(url: url)
            description.shouldInferMappingModelAutomatically = true
            description.shouldMigrateStoreAutomatically = true
            container.persistentStoreDescriptions = [description]
        } else {
            container = NSPersistentContainer(name: containerName)
        }
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //Main MOC
    lazy var mainContext: NSManagedObjectContext = {
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        return persistentContainer.viewContext
    }()
    
    //New Background MOC
    func newBackgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    // MARK: - Core Data Saving support
    class func saveContext(_ managedObjectContext: NSManagedObjectContext,
                           _ completion:@escaping ((Error?) -> Void) = { _ in }) {
        managedObjectContext.perform {
            if (managedObjectContext.hasChanges) {
                do {
                    try managedObjectContext.save()
                    print("MOC Save Success")
                    completion(nil)
                } catch {
                    print("MOC Save Error: \(error)")
                    managedObjectContext.undo()
                    completion(error)
                }
            } else {
                completion(nil)
            }
        }
    }
}
