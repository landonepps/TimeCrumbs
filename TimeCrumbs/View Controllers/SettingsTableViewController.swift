//
//  SettingsTableViewController.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 11/26/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit
import CoreData

class SettingsTableViewController: UITableViewController {
    
    // Set by the SceneDelegate's scene(scene:willConnectTo:options:) method
    var moc: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

extension SettingsTableViewController: CoreDataClient {
    func set(moc: NSManagedObjectContext) {
        self.moc = moc
    }
}
