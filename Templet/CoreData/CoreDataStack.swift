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
    
    #warning("调整modelName")
    static let modelName = ""
    #warning("调整CloudkitID")
    static let cloudKit = "iCloud.com.hzjuzhi.TricolorTime"
    static let shared: CoreDataStack = CoreDataStack(modelName: modelName,
                                                     cloudKit: cloudKit)
    
    private let modelName: String
    private let cloudKit: String?
    
    private init(modelName: String, cloudKit: String? = nil) {
        self.modelName = modelName
        self.cloudKit = cloudKit
    }
    
    // 使用CloudKitContainer
    lazy var storeContainer: NSPersistentCloudKitContainer = {
        
        let container = NSPersistentCloudKitContainer(name: self.modelName)
   
        #if DEBUG
        // 在debug的时候重置schema https://developer.apple.com/documentation/coredata/mirroring_a_core_data_store_with_cloudkit/creating_a_core_data_model_for_cloudkit
        do {
            try container.initializeCloudKitSchema(options: [])
        } catch {
        }
        #endif
        
        // 允许 persistent history tracking
        if let persistentStoreDescription = container.persistentStoreDescriptions.first {
            persistentStoreDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
            persistentStoreDescription.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
            
            // 配置cloudKit
            if let cloudKit = cloudKit {
                persistentStoreDescription.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: cloudKit)
            }
            
        }
        
        
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                print("CoreData 加载失败 \(error), \(error.userInfo)")
            }
            
            // 自动同步
            container.viewContext.automaticallyMergesChangesFromParent = true
            
            // 避免后台同步的时候刷新UI,https://developer.apple.com/documentation/coredata/accessing_data_when_the_store_changes
            do {
              try container.viewContext.setQueryGenerationFrom(.current)
            } catch {
              fatalError("###\(#function): Failed to pin viewContext to the current generation:\(error)")
            }
        }
        return container
    }()
    
    // main thread use NSMergeByPropertyObjectTrumpMergePolicyType, https://stackoverflow.com/questions/8134562/which-nsmergepolicy-do-i-use
    lazy var managedContext: NSManagedObjectContext = {
        self.storeContainer.viewContext.mergePolicy =  NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        return self.storeContainer.viewContext
    }()
    
    // optimistic locking failure 问题可以查看此文档 这里进行忽略处理 https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/ChangeManagement.html
    func saveContext() {
        guard self.managedContext.hasChanges else { return }
        do {
            try self.managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
