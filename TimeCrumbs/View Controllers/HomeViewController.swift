//
//  HomeViewController.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 12/7/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit
import SwiftUI
import CoreData

class HomeViewController: UIViewController {
    
    // Set by the SceneDelegate's scene(scene:willConnectTo:options:) method
    var moc: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    
    @IBAction func comingFromEditProjectUnwindSegue(segue: UIStoryboardSegue) {
        
    }
    @IBSegueAction func addHomeView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: HomeView())
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

extension HomeViewController: CoreDataClient {
    func set(moc: NSManagedObjectContext) {
        self.moc = moc
    }
}
