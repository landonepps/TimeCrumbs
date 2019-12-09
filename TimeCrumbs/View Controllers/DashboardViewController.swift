//
//  DashboardViewController.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 11/26/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit
import CoreData

class DashboardViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var totalIncomeLabel: UILabel!
    @IBOutlet weak var timeCrumbTotalLabel: UILabel!
    @IBOutlet weak var congratulationsLabel: UILabel!    
    
    // Set by the SceneDelegate's scene(scene:willConnectTo:options:) method
    var moc: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpViews()
    }
    
    func setUpViews() {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        guard let tasks = try? moc.fetch(fetchRequest) else { return }
        
        var totalTime = 0.0
        var totalIncome: NSDecimalNumber = 0.0
        var timeCrumbTotal: NSDecimalNumber = 0.0
        
        for task in tasks {
            guard let project = task.project else { continue }
            let duration = task.duration
            totalTime += duration
            
            if task.project?.isHourly ?? false,
                let rate = project.rate {
                let taskIncome = rate.multiplying(by: NSDecimalNumber(value: duration)).dividing(by: 3600)
                totalIncome = totalIncome.adding(taskIncome)
                
                if duration <= 1800 {
                    timeCrumbTotal = timeCrumbTotal.adding(taskIncome)
                }
            }
        }
        
        hoursLabel.text = format(duration: totalTime)
        totalIncomeLabel.text = totalIncome.asCurrency()
        timeCrumbTotalLabel.text = timeCrumbTotal.asCurrency()
        
        if timeCrumbTotal.compare(0) == .orderedDescending,
            let totalString = timeCrumbTotal.asCurrency() {
            congratulationsLabel.text = "Congratulations - you made an extra \(totalString) by tracking your Time Crumb tasks under 30 minutes!"
        }
    }
    
    func format(duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 2
        
        return formatter.string(from: duration)!
    }
    
}

extension DashboardViewController: CoreDataClient {
    func set(moc: NSManagedObjectContext) {
        self.moc = moc
    }
}
