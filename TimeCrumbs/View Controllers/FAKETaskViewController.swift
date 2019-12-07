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
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var dateDatePicker: UIDatePicker!
    @IBOutlet weak var minutesDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        
            guard let project = project
            else { return }
                
        let name = taskNameField.text ?? "Not Working"
        let startTime = Date()
        let duration = minutesDatePicker.countDownDuration
        let date = dateDatePicker.date
        let moc = project.managedObjectContext!

        TaskController.createTask(project: project, name: name, startTime: startTime, duration: duration, date: date, moc: moc)
        
        navigationController?.popViewController(animated: true)
    }
}
