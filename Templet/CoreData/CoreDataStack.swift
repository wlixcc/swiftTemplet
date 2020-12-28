//
//  CoreDataStack.swift
//  Cooker
//
//  Created by wl on 2020/3/13.
//  Copyright © 2020 hzjuzhi. All rights reserved.
//

import Foundation
import CoreData
import os

class CoreDataStack {
    //default App model
    static let shared: CoreDataStack = CoreDataStack(modelName: "modelname")
    
    private let modelName: String
    
    private init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var storeContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // main thread use NSMergeByPropertyObjectTrumpMergePolicyType, https://stackoverflow.com/questions/8134562/which-nsmergepolicy-do-i-use
    lazy var managedContext: NSManagedObjectContext = {
        self.storeContainer.viewContext.mergePolicy =  NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        return self.storeContainer.viewContext
    }()
    
    func saveContext() {
        guard self.managedContext.hasChanges else { return }
        
        do {
            try self.managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
