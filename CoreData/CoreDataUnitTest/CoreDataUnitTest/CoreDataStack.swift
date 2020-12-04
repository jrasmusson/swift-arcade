//
//  CoreDataManager.swift
//  CoreDataUnitTest
//
//  Created by jrasmusson on 2020-11-15.
//

// https://williamboles.me/can-unit-testing-and-core-data-become-bffs/
// https://medium.com/@aliakhtar_16369/mastering-in-coredata-part-11-multithreading-concurrency-rules-70f1f221dbcd

import Foundation
import CoreData

/*
 This is the CoreDataManager used by the app. It saves changes to disk.

 Managers can do operations via the:
 - `mainContext` with interacts on the main UI thread, or
 - `backgroundContext` with has a separate queue for background processing

 */
class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    let persistentContainer: NSPersistentContainer
    let backgroundContext: NSManagedObjectContext
    let mainContext: NSManagedObjectContext
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "MyData")
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = NSSQLiteStoreType
        
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
        }
        
        mainContext = persistentContainer.viewContext
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        backgroundContext.parent = self.mainContext
    }
}
