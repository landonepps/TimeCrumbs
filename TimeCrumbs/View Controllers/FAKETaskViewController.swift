//
//  FAKETaskViewController.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 12/6/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit
import CoreData

class FAKETaskViewController: UIViewController {
    
    var category: Category?
    var project: Project?

    // MARK: - Outlets
    @IBOutlet weak var dateDatePicker: UIDatePicker!
    @IBOutlet weak var minutesDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        
            guard let project = project
            else { return }
        let moc = project.managedObjectContext!
        let startTime = Date()
        let duration = minutesDatePicker.countDownDuration
        let date = dateDatePicker.date

        TaskController.createTask(project: project, startTime: startTime, duration: duration, date: date, moc: moc)
        
        navigationController?.popViewController(animated: true)
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
