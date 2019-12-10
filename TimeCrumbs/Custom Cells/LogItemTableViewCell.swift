//
//  LogItemTableViewCell.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 12/2/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

class LogItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dollarAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with task: Task) {
        
        projectNameLabel.text = task.project?.name
        if let projectColorName = task.project?.color,
            let projectColor = UIColor(named: projectColorName)
        {
            projectNameLabel.textColor = projectColor
        }
        
        let taskDuration = format(duration: task.duration)
        if let date = task.date {
            dateLabel.text = format(date: date)
        }
        
        taskNameLabel.text = task.name
        timeLabel.text = taskDuration
        
        if task.project?.isHourly == true {
            dollarAmountLabel.text = (task.project?.rate ?? 0).multiplying(by: NSDecimalNumber(value: task.duration)).dividing(by: NSDecimalNumber(3600)).asCurrency()
        } else {
            dollarAmountLabel.text = "—"
        }
    }
    
    // MARK: Value Formatting
    
    func format(duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 2
        
        return formatter.string(from: duration)!
    }
    
    func format(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        
        return dateFormatter.string(from: date)
    }
}
