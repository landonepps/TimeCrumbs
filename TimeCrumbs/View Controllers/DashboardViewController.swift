//
//  DashboardViewController.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 11/26/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit
import CoreData

class DashboardViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var dateRangeButton: UIButton!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var dollarAmountLabel: UILabel!
    @IBOutlet weak var timeCrumbsImageView: UIImageView!
    @IBOutlet weak var timeCrumbsDollarLabel: UILabel!
    @IBOutlet weak var congratulationsLabel: UILabel!
    @IBOutlet weak var earningsContainerView: UIView!
    
    
    // Set by the SceneDelegate's scene(scene:willConnectTo:options:) method
    var moc: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DashboardViewController: CoreDataClient {
    func set(moc: NSManagedObjectContext) {
        self.moc = moc
    }
}
