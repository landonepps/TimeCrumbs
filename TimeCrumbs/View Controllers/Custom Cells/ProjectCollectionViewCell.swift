//
//  ProjectCollectionViewCell.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 12/2/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

class ProjectCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var projectColorView: UIView!
    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var logTimeButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var logTimeLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    
    @IBAction func logTimeButtonTapped(_ sender: Any) {
    }
    @IBAction func startButtonTapped(_ sender: Any) {
    }
    
}
