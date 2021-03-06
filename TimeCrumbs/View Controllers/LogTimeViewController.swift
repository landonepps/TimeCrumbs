//
//  LogTimeViewController.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 12/7/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

class LogTimeViewController: UIViewController {
    
    // MARK: - Properties
    
    var project: Project?
    var task: Task?
    
    // MARK: - Outlets

    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var durationPicker: UIDatePicker!
    @IBOutlet weak var projectColorView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        dismissKeyboardOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // block double-tap on tab bar to navigate to root
        tabBarController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // disable blocking double-tap on tab bar
        tabBarController?.delegate = nil
    }
    
    // MARK: - Actions
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let project = project,
            let moc = project.managedObjectContext
        else { return }
        
        
        var taskName = taskNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if taskName?.isEmpty ?? false {
            taskName = nil
        }
        
        let duration: Double = durationPicker.countDownDuration
        let date = datePicker.date
        
        if let task = task {
            TaskController.updateTask(task, name: taskName, date: date, duration: duration)
        } else {
            TaskController.createTask(project: project, name: taskName, duration: duration, date: date, moc: moc)
        }
        
        saveButton.setImage(UIImage(named: "saveButtonCheck"), for: .normal)
        saveButton.setTitle("", for: .normal)
        saveButton.tintColor = UIColor(named: "saveButtonColor")
        saveButton.imageView?.tintColor = UIColor.white
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    // MARK: - Helper Methods

    func setupViews() {
        guard let project = project else { return }
        
        projectNameLabel.text = project.name
        taskNameTextField.delegate = self

        if let projectColorName = project.color,
            let projectColor = UIColor(named: projectColorName) {
            projectColorView.backgroundColor = projectColor
            saveButton.tintColor = projectColor
        }
        
        if let taskName = task?.name {
            taskNameTextField.text = taskName
        }
        
        let currentDate = Date()
        datePicker.maximumDate = currentDate
        if let date = task?.date {
            datePicker.date = date
        } else {
            datePicker.date = currentDate
        }
        
        if let duration = task?.duration {
            durationPicker.minuteInterval = 1
            durationPicker.countDownDuration = duration
        } else {
            durationPicker.countDownDuration = 1_800 // 30 minutes in seconds
        }
    }
    
    func dismissKeyboardOnTap() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}

extension LogTimeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension LogTimeViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let indexOfNewVC = tabBarController.viewControllers?.firstIndex(of: viewController)
        return (indexOfNewVC != 0) || (indexOfNewVC != tabBarController.selectedIndex)
    }
}
