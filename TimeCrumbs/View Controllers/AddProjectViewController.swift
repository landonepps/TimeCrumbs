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
    var colorButtons = [UIButton]()
    var selectedColorName: String?
    
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
        selectColor(named: Colors.projectColorNames.first!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        selectedColorView.layer.cornerRadius = 7
    }
    
    // MARK: - Actions
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let projectName = projectNameTextField.text,
            projectName.isEmpty == false,
            
            let projectColorName = selectedColorName
            else { return }
        
        var clientName = "Client"
        var rate: Decimal = 0.0
        
        if let _clientName = clientNameTextField.text,
            _clientName.isEmpty == false
            {
            clientName = _clientName
        }
        
        if let rateString = billingRateTextField.text,
            let _rate = Decimal(string: rateString) {
            rate = _rate
        }
        
        let isHourly = billingTypeSegmentedControl.selectedSegmentIndex == 0 ? true : false
        
        ProjectController.createProject(name: projectName, clientName: clientName, rate: rate, isHourly: isHourly, color: projectColorName, moc: moc)
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func archiveProjectButtonTapped(_ sender: Any) {
    }
    
    @IBAction func deleteProjectButtonTapped(_ sender: Any) {
        presentDeleteAlertController()
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
    // MARK: - Helper Functions
    func presentDeleteAlertController() {
        
        let alertController = UIAlertController(title: "Delete Project", message: "This action cannot be undone. Delete Project?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    func makeColorButton(color: UIColor) -> UIButton {
        
        let colorButton = UIButton()
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        colorButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        colorButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        colorButton.backgroundColor = color
        colorButton.layer.cornerRadius = 7
        colorButton.layer.masksToBounds = true
        
        return colorButton
    }
    
    func setUpColorStackView() {
        
        for colorName in Colors.projectColorNames {
            let colorButton = makeColorButton(color: UIColor(named: colorName)!)
            colorButton.addTarget(self, action: #selector(colorButtonTapped(sender:)), for: .touchUpInside)
            colorButtons.append(colorButton)
            projectColorSelectionStackView.addArrangedSubview(colorButton)
        }
    }
    
    
    @objc func colorButtonTapped(sender: UIButton) {
        
        guard let index = colorButtons.firstIndex(of: sender)
            else { return }
        
        selectColor(named: Colors.projectColorNames[index])
    }
    
    func selectColor(named name: String) {
        
        guard let color = UIColor(named: name) else { return }
        selectedColorView.backgroundColor = color
        selectedColorName = name
    }
}
