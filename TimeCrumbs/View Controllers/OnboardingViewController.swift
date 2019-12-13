//
//  OnboardingViewController.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 12/12/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func enableNotificationsButtonTapped(_ sender: Any) {
        NotificationManager.requestPermission { granted in
            DispatchQueue.main.async {
                if !granted {
                    UIAlertController.presentTemporaryAlert(in: self, title: "Permission Denied", message: "Please enable notifications in settings.")
                } else {
                    UIAlertController.presentTemporaryAlert(in: self, title: "Permission Already Granted", message: "Notifications are already enabled on this device.")
                }
            }
        }
    }
    
    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
