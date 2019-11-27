//
//  SceneDelegate.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 11/20/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        // Inject the managed object context in all the tabs
        if let rootVC = window?.rootViewController as? UITabBarController {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            
            for child in rootVC.viewControllers ?? [] {
                if let navigationController = child as? UINavigationController,
                    let top = navigationController.topViewController as? CoreDataClient,
                    let context = appDelegate?.persistentContainer.viewContext
                {
                    top.set(moc: context)
                }
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.persistentContainer.viewContext.saveOrRollback()
    }

}

