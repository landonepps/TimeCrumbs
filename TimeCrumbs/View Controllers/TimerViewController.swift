//
//  TimerViewController.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 12/7/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    // MARK: - Properties
    
    var project: Project?
    
    // MARK: - Outlets
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var projectColorView: UIView!
    @IBOutlet weak var timerImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
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
    
    @IBAction func finishButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Finish", message: "Are you sure you're finished?", preferredStyle: .alert)
        let goBackAction = UIAlertAction(title: "Go Back", style: .cancel, handler: nil)
        let finishAction = UIAlertAction(title: "Finish", style: .default) { _ in
            self.performSegue(withIdentifier: "TimerToLogTime", sender: self)
        }
        alertController.addAction(goBackAction)
        alertController.addAction(finishAction)
        present(alertController, animated: true)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TimerToLogTime" {
            guard let destination = segue.destination as? LogTimeViewController else { return }
            
            destination.project = project
        }
    }
    
    // MARK: - Helper Methods
    
    func setupViews() {
        // Background View Shadow
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOpacity = 0.2
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        backgroundView.layer.shadowRadius = 7.0
        backgroundView.layer.masksToBounds = false
        
        guard let project = project else { return }
        
        if let projectColorName = project.color, let projectColor = UIColor(named: projectColorName) {
            projectColorView.backgroundColor = projectColor
            timerImageView.tintColor = projectColor
            finishButton.tintColor = projectColor
            startButton.tintColor = projectColor
        }
    }

}

extension TimerViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let indexOfNewVC = tabBarController.viewControllers?.firstIndex(of: viewController)
        return (indexOfNewVC != 0) || (indexOfNewVC != tabBarController.selectedIndex)
    }
}
