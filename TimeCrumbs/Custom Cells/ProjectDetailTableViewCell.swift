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
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
