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
    
    // MARK: - Actions
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let project = project,
            let moc = project.managedObjectContext
        else { return }
        
        guard let taskName = taskNameTextField.text, taskName.isEmpty == false
        else {
            UIAlertController.presentTemporaryAlert(in: self, title: "Unable to Save", message: "Missing Task Name")
            return
        }
        
        let duration: Double = durationPicker.countDownDuration
        let date = datePicker.date
        
        TaskController.createTask(project: project, name: taskName, duration: duration, date: date, moc: moc)
        
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
        
        datePicker.date = Date()
        durationPicker.countDownDuration = 1_800 // 30 minutes in seconds
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
