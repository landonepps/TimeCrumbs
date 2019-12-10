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
    let notificationManager = NotificationManager()
    var checkInIsShort: Bool = false
    var resumeIsShort: Bool = false
    
    // MARK: - Outlets
    
    @IBOutlet weak var projectCheckInSwitch: UISwitch!
    @IBOutlet weak var resumeTimerSwitch: UISwitch!
    @IBOutlet weak var projectCheckInAlertFrequencyButton: UIButton!
    @IBOutlet weak var resumeTimerAlertFrequencyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func projectCheckInSwitchToggled(_ sender: Any) {
        
    }
    
    @IBAction func resumeTimerSwitchToggled(_ sender: Any) {
    }
    
    @IBAction func projectCheckInAlertFrequencyButtonTapped(_ sender: Any) {
        checkInIsShort.toggle()
        if checkInIsShort {
            projectCheckInAlertFrequencyButton.setTitle("15 min", for: .normal)
        } else {
            projectCheckInAlertFrequencyButton.setTitle("30 min", for: .normal)
        }
        UserDefaults.standard.set(checkInIsShort, forKey: "checkInIsShort")
    }
    
    @IBAction func resumeTimerAlertFrequencyButtonTapped(_ sender: Any) {
        resumeIsShort.toggle()
        if resumeIsShort {
            resumeTimerAlertFrequencyButton.setTitle("15 min", for: .normal)
        } else {
            resumeTimerAlertFrequencyButton.setTitle("30 min", for: .normal)
        }
        UserDefaults.standard.set(resumeIsShort, forKey: "resumeIsShort")
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

extension SettingsTableViewController: CoreDataClient {
    func set(moc: NSManagedObjectContext) {
        self.moc = moc
    }
}
