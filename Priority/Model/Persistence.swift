//
//  Persistence.swift
//  Priority
//
//  Created by Victor Zerefos on 06/07/21.
//

import CoreData

struct PersistenceController {
    //: - 1 Persistent controller
    static let shared = PersistenceController()
    //: - 2 Persistent container
    let container: NSPersistentContainer
    //: - 3 Initialization (load the persistent store)
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Priority")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    //: - 4 Preview
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<5 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = "Sample task \(i)"
            newItem.completion = false
            newItem.id = UUID()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
