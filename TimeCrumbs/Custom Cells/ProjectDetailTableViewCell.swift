//
//  ProjectDetailTableViewCell.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 12/5/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

class ProjectDetailTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func update(with task: Task) {
        let taskDuration = format(duration: task.duration)
        
        taskNameLabel.text = task.name
        durationLabel.text = taskDuration
        
        totalAmountLabel.text = (task.project?.rate ?? 0).multiplying(by: NSDecimalNumber(value: task.duration)).dividing(by: NSDecimalNumber(3600)).asCurrency()
    }
    
    func format(duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 1
        
        return formatter.string(from: duration)!
    }
    
    func format(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        
        return dateFormatter.string(from: date)
    }
}


