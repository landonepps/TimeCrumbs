//
//  AppDelegate.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 11/20/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        #warning("Remove code to reset DB & generate dummy data")
        print("Removing all records in:", persistentContainer.name)
        // create the delete request for the specified entity
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Project.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        let backgroundMOC = persistentContainer.newBackgroundContext()

        // perform the delete
        do {
            try backgroundMOC.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
        
        backgroundMOC.saveOrRollback()
        
        print("Recreating dummy project")
        print("Is main thread?: \(Thread.isMainThread)")
        ProjectController.createProject(name: "Project 1", color: "lightOrange", moc: persistentContainer.viewContext)
        ProjectController.createProject(name: "Project 2", color: "orange", moc: persistentContainer.viewContext)
        ProjectController.createProject(name: "Project 3", color: "cerulean", moc: persistentContainer.viewContext)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentCloudKitContainer = {

        let container = NSPersistentCloudKitContainer(name: "TimeCrumbs")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Failed to load store: \(error), \(error.userInfo)")
            }
        }
        return container
    }()

}

