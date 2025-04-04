//
//  PersistenceController.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/4/25.
//


import CoreData

final class PersistenceController {
    
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "HealthDataModel") // must match xcdatamodeld name

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error: \(error)")
            }
        }
    }
}
