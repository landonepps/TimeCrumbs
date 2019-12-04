//
//  AddProjectViewController.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 12/4/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit
import CoreData

class AddProjectViewController: UIViewController {
    
    var moc: NSManagedObjectContext!
    
    // MARK: - Outlets
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var clientNameTextField: UITextField!
    @IBOutlet weak var billingRateTextField: UITextField!
    @IBOutlet weak var billingTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var selectedColorView: UIView!
    @IBOutlet weak var projectColorSelectionStackView: UIStackView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpColorStackView()
    }
    
    // MARK: - Actions
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
//        guard let projectName = projectNameTextField.text,
//            let projectColor = "\(projectColorSelectionStackView)"
//
//        ProjectController.createProject(name: <#T##String#>, color: <#T##String#>, moc: moc)
    }
    
    @IBAction func archiveProjectButtonTapped(_ sender: Any) {
    }
    
    @IBAction func deleteProjectButtonTapped(_ sender: Any) {
        presentDeleteAlertController()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Helper Functions
    func presentDeleteAlertController() {
        let alertController = UIAlertController(title: "Delete Project", message: "This action cannot be undone. Delete Project?", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    func makeColorView(color: UIColor) -> UIView {
        
        let colorView = UIView()
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.heightAnchor.constraint(equalToConstant: 31).isActive = true
        colorView.widthAnchor.constraint(equalToConstant: 31).isActive = true
        colorView.backgroundColor = color
        colorView.layer.cornerRadius = 7
        colorView.layer.masksToBounds = true
        // Add border
        
        return colorView
    }
    
    func setUpColorStackView() {
        for colorName in Colors.projectColorNames {
            let colorView = makeColorView(color: UIColor(named: colorName)!)
            projectColorSelectionStackView.addArrangedSubview(colorView)
        }
    }
}
