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
    var checkInIsShort: Bool = false
    var resumeIsShort: Bool = false
    var checkInIsEnabled: Bool = false
    var resumeIsEnabled: Bool = false
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var projectCheckInSwitch: UISwitch!
    @IBOutlet weak var resumeTimerSwitch: UISwitch!
    @IBOutlet weak var projectCheckInAlertFrequencyButton: UIButton!
    @IBOutlet weak var resumeTimerAlertFrequencyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    // MARK: - Actions
    
    @IBAction func projectCheckInSwitchToggled(_ sender: UISwitch) {
        if sender.isOn {
            NotificationManager.requestPermission { granted in
                DispatchQueue.main.async {
                    if granted {
                        self.checkInIsEnabled = sender.isOn
                        UserDefaults.standard.set(self.checkInIsEnabled, forKey: "checkInIsEnabled")
                    } else {
                        sender.isOn = false
                        UIAlertController.presentTemporaryAlert(in: self, title: "Permission Denied", message: "Please enable notifications in settings.")
                    }
                }
            }
        } else {
            checkInIsEnabled = sender.isOn
            UserDefaults.standard.set(checkInIsEnabled, forKey: "checkInIsEnabled")
        }
    }
    
    @IBAction func resumeTimerSwitchToggled(_ sender: UISwitch) {
        if sender.isOn {
            NotificationManager.requestPermission { granted in
                DispatchQueue.main.async {
                    if granted {
                        self.resumeIsEnabled = sender.isOn
                        UserDefaults.standard.set(self.resumeIsEnabled, forKey: "resumeIsEnabled")
                    } else {
                        sender.isOn = false
                        UIAlertController.presentTemporaryAlert(in: self, title: "Permission Denied", message: "Please enable notifications in settings.")
                    }
                }
            }
        } else {
            resumeIsEnabled = sender.isOn
            UserDefaults.standard.set(resumeIsEnabled, forKey: "resumeIsEnabled")
        }
    }
    
    @IBAction func projectCheckInAlertFrequencyButtonTapped(_ sender: Any) {
        checkInIsShort.toggle()
        UserDefaults.standard.set(checkInIsShort, forKey: "checkInIsShort")
        updateViews()
    }
    
    @IBAction func resumeTimerAlertFrequencyButtonTapped(_ sender: Any) {
        resumeIsShort.toggle()
        UserDefaults.standard.set(resumeIsShort, forKey: "resumeIsShort")
        updateViews()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    func updateViews() {
        checkInIsEnabled = UserDefaults.standard.bool(forKey: "checkInIsEnabled")
        resumeIsEnabled = UserDefaults.standard.bool(forKey: "resumeIsEnabled")
        
        checkInIsShort = UserDefaults.standard.bool(forKey: "checkInIsShort")
        resumeIsShort = UserDefaults.standard.bool(forKey: "resumeIsShort")
        
        projectCheckInSwitch.isOn = checkInIsEnabled
        resumeTimerSwitch.isOn = resumeIsEnabled
        
        if checkInIsShort {
            projectCheckInAlertFrequencyButton.setTitle("15 min", for: .normal)
        } else {
            projectCheckInAlertFrequencyButton.setTitle("30 min", for: .normal)
        }
        
        if resumeIsShort {
            resumeTimerAlertFrequencyButton.setTitle("15 min", for: .normal)
        } else {
            resumeTimerAlertFrequencyButton.setTitle("30 min", for: .normal)
        }
    }
    
    
    
}

extension SettingsTableViewController: CoreDataClient {
    func set(moc: NSManagedObjectContext) {
        self.moc = moc
    }
}
