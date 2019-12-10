//
//  TimerViewController.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 12/7/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit
import CoreData

class TimerViewController: UIViewController {
    
    // MARK: - Properties
    
    var project: Project?
    var task: Task?
    
    var timer: Timer?
    
    // MARK: - Outlets
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var projectColorView: UIView!
    @IBOutlet weak var timerImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // block double-tap on tab bar to navigate to root
        tabBarController?.delegate = self
        
        setupTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // disable blocking double-tap on tab bar
        tabBarController?.delegate = nil
    }
    
    // MARK: - Actions
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Cancel Timer?", message: "If you cancel the timer, your current task won't be saved.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { [weak self] _ in
            guard let self = self, let task = self.task else { return }
            TaskController.deleteTask(task)
            self.navigationController?.popViewController(animated: true)
        }
        let goBackAction = UIAlertAction(title: "Go Back", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(goBackAction)
        
        present(alertController, animated: true)
    }
    
    @IBAction func pauseButtonTapped(_ sender: Any) {
        guard let task = task else { return }
        
        if task.startTime == nil {
            TaskController.resumeTask(task)
            
            pauseButton.setTitle("Pause", for: .normal)
            
            if let projectColorName = project?.color, let projectColor = UIColor(named: projectColorName) {
                timerImageView.tintColor = projectColor
            }
            
            NotificationManager.deletePendingNotifications()
            if UserDefaults.standard.bool(forKey: "checkInIsEnabled") {
                if UserDefaults.standard.bool(forKey: "checkInIsShort") {
                    NotificationManager.fireCheckInNotification(timeInterval: 900)
                } else {
                    NotificationManager.fireCheckInNotification(timeInterval: 1800)
                }
            }
            
        } else {
            TaskController.pauseTask(task)
            
            pauseButton.setTitle("Resume", for: .normal)
            
            if let projectColorName = project?.color {
                let lightProjectColorName = "light" + projectColorName.prefix(1).capitalized + projectColorName.dropFirst()

                timerImageView.tintColor = UIColor(named: lightProjectColorName)
            }
            
            NotificationManager.deletePendingNotifications()
            if UserDefaults.standard.bool(forKey: "resumeIsEnabled") {
                if UserDefaults.standard.bool(forKey: "resumeIsShort") {
                    NotificationManager.fireResumeTimerNotification(timeInterval: 900)
                } else {
                    NotificationManager.fireResumeTimerNotification(timeInterval: 1800)
                }
            }
        }
    }
    
    @IBAction func finishButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Finish", message: "Are you sure you're finished?", preferredStyle: .alert)
        let goBackAction = UIAlertAction(title: "Go Back", style: .cancel, handler: nil)
        let finishAction = UIAlertAction(title: "Finish", style: .default) { _ in
            guard let task = self.task else { return }
            TaskController.pauseTask(task)
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
            destination.task = task
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
            pauseButton.tintColor = projectColor
        }
    }

    func setupTimer() {
        guard let project = project,
            let moc = project.managedObjectContext
        else { return }
        
        if task == nil {
            // If the project already has a task started, use that
            let request: NSFetchRequest<Task> = Task.fetchRequest()
            request.predicate = NSPredicate(format: "(project = %@) AND (startTime != nil)", project)
            if let startedTasks = try? project.managedObjectContext?.fetch(request),
                startedTasks.count > 0 {
                
                task = startedTasks.first
            } else {
                // Otherwise, create a new task
                let currentTime = Date()
                task = TaskController.createTask(project: project, startTime: currentTime, date: currentTime, moc: moc)
            }
            NotificationManager.deletePendingNotifications()
            if UserDefaults.standard.bool(forKey: "checkInIsEnabled") {
                if UserDefaults.standard.bool(forKey: "checkInIsShort") {
                    NotificationManager.fireCheckInNotification(timeInterval: 900)
                } else {
                    NotificationManager.fireCheckInNotification(timeInterval: 1800)
                }
            }
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] timer in
            guard let self = self else { return }
            
            self.updateViews()
        })
        
        updateViews()
    }
    
    func updateViews() {
        guard let task = self.task,
            let startTime = task.startTime
        else { return }
        
        let elapsedTime = Date().timeIntervalSince(startTime) + task.duration
        
        let seconds = Int(elapsedTime.truncatingRemainder(dividingBy: 60))
        let minutes = Int(elapsedTime.truncatingRemainder(dividingBy: 3600) / 60)
        let hours = Int(elapsedTime / 3600)
        self.timeLabel.text = String(format: "%.2d:%.2d:%.2d", hours, minutes, seconds)
    }
}

extension TimerViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let indexOfNewVC = tabBarController.viewControllers?.firstIndex(of: viewController)
        return (indexOfNewVC != 0) || (indexOfNewVC != tabBarController.selectedIndex)
    }
}
